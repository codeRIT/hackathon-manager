require 'test_helper'

class QuestionnaireTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  should belong_to :user
  should belong_to :school
  should belong_to :bus_list
  should have_and_belong_to_many :agreements

  should validate_uniqueness_of :user_id

  should strip_attribute :acc_status
  should strip_attribute :major
  should strip_attribute :gender
  should strip_attribute :dietary_restrictions
  should strip_attribute :special_needs
  should strip_attribute :travel_location
  should strip_attribute :why_attend

  should validate_presence_of :date_of_birth
  should validate_presence_of :experience
  should validate_presence_of :interest
  should validate_presence_of :shirt_size
  should validate_presence_of :phone
  should validate_presence_of :level_of_study
  should validate_presence_of :major
  should validate_presence_of :gender
  should validate_presence_of :graduation_year
  should validate_presence_of :race_ethnicity
  should_not validate_presence_of :why_attend
  should_not validate_presence_of :dietary_restrictions
  should_not validate_presence_of :special_needs
  should_not validate_presence_of :resume
  should_not validate_presence_of :international
  should_not validate_presence_of :portfolio_url
  should_not validate_presence_of :vcs_url
  should_not validate_presence_of :acc_status
  should_not validate_presence_of :acc_status_author_id
  should_not validate_presence_of :acc_status_date
  should_not validate_presence_of :can_share_info
  should_not validate_presence_of :travel_not_from_school
  should_not validate_presence_of :travel_location
  should_not validate_presence_of :boarded_bus_at

  should validate_length_of(:dietary_restrictions).is_at_most(500)
  should validate_length_of(:special_needs).is_at_most(500)

  should allow_value("first").for(:experience)
  should allow_value("experienced").for(:experience)
  should allow_value("expert").for(:experience)
  should_not allow_value("foo").for(:experience)

  should allow_value("design").for(:interest)
  should allow_value("software").for(:interest)
  should allow_value("hardware").for(:interest)
  should_not allow_value("foo").for(:interest)

  should allow_value("Women's - XS").for(:shirt_size)
  should allow_value("Women's - S").for(:shirt_size)
  should allow_value("Women's - M").for(:shirt_size)
  should allow_value("Women's - L").for(:shirt_size)
  should allow_value("Women's - XL").for(:shirt_size)
  should allow_value("Unisex - XS").for(:shirt_size)
  should allow_value("Unisex - S").for(:shirt_size)
  should allow_value("Unisex - M").for(:shirt_size)
  should allow_value("Unisex - L").for(:shirt_size)
  should allow_value("Unisex - XL").for(:shirt_size)
  should_not allow_value("M").for(:shirt_size)
  should_not allow_value("foo").for(:shirt_size)

  should allow_value(Agreement.all).for(:agreements)

  should allow_value("pending").for(:acc_status)
  should allow_value("accepted").for(:acc_status)
  should allow_value("waitlist").for(:acc_status)
  should allow_value("denied").for(:acc_status)
  should allow_value("late_waitlist").for(:acc_status)
  should allow_value("rsvp_confirmed").for(:acc_status)
  should allow_value("rsvp_denied").for(:acc_status)
  should_not allow_value("foo").for(:acc_status)

  should have_attached_file(:resume)

  should "allow attachment of resume" do
    questionnaire = create(:questionnaire)
    questionnaire.resume.attach(io: sample_file, filename: 'sample_pdf.pdf')
    questionnaire.reload
    assert_equal true, questionnaire.resume.attached?
    assert_equal "sample_pdf.pdf", questionnaire.resume.filename.to_s
  end

  should "allow deletion via delete_resume attribute" do
    questionnaire = create(:questionnaire)
    questionnaire.resume.attach(io: sample_file, filename: 'sample_pdf.pdf')
    questionnaire.reload
    assert_equal true, questionnaire.resume.attached?
    questionnaire.delete_resume = "1"
    questionnaire.save
    assert_equal false, questionnaire.resume.attached?
  end

  should allow_value('foo.com').for(:portfolio_url)
  should allow_value('github.com/foo', 'gitlab.com/bar', 'bitbucket.org/baz').for(:vcs_url)
  should allow_value('https://github.com/foo', 'https://gitlab.com/bar', 'https://bitbucket.org/baz').for(:vcs_url)
  should allow_value('HttPs://gITHub.CoM/foo', 'hTTp://gitLAB.coM/bar').for(:vcs_url)
  should allow_value('wWw.gITHub.CoM/fOo', 'hTTp://wWw.gitLAB.coM/f-fc-vx').for(:vcs_url)
  should_not allow_value('http://foo.com', 'https://bar.com').for(:vcs_url)

  context "#school" do
    should "return nil if no school set" do
      questionnaire = create(:questionnaire)
      questionnaire.update_attribute(:school_id, nil)
      assert_nil questionnaire.school
    end

    should "return the current school" do
      school = create(:school, name: "My University")
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal "My University", questionnaire.school.name
    end

    should "increment school questionnaire counter on create" do
      school = create(:school)
      create(:questionnaire, school_id: school.id)
      assert_equal 1, school.reload.questionnaire_count
    end

    should "update school questionnaire counters on update" do
      school1 = create(:school, name: "School 1")
      school2 = create(:school, name: "School 2", id: 2)
      questionnaire = create(:questionnaire, school_id: school1.reload.id)
      questionnaire.school_id = school2.id
      questionnaire.save
      assert_equal 0, school1.reload.questionnaire_count
      assert_equal 1, school2.reload.questionnaire_count
    end

    should "decrement school questionnaire counter on destroy" do
      school = create(:school)
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal 1, school.reload.questionnaire_count
      questionnaire.destroy
      assert_equal 0, school.reload.questionnaire_count
    end
  end

  context "#school_name" do
    should "return nil if no school set" do
      questionnaire = create(:questionnaire)
      questionnaire.update_attribute(:school_id, nil)
      assert_nil questionnaire.school_name
    end

    should "return the current school's name" do
      school = create(:school, name: "My University")
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal "My University", questionnaire.school_name
    end
  end

  context "#full_location" do
    should "concatenate city and state with a comma" do
      school = create(:school, city: "Foo", state: "AZ")
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal "Foo, AZ", questionnaire.full_location
    end
  end

  context "#date_of_birth_formatted" do
    should "format date_of_birth correctly" do
      questionnaire = create(:questionnaire, date_of_birth: Date.new(1995, 1, 5))
      assert_equal "January 5, 1995", questionnaire.date_of_birth_formatted
    end
  end

  context "#email" do
    should "return the questionnaire's user" do
      questionnaire = create(:questionnaire)
      questionnaire.user.email = "joe.smith@example.com"
      assert_equal "joe.smith@example.com", questionnaire.email
    end

    should "return nil without a user" do
      questionnaire = build(:questionnaire, user: nil)
      assert_nil questionnaire.email
    end
  end

  context "#acc_status_author" do
    should "return nil if no author" do
      questionnaire = create(:questionnaire, acc_status_author_id: nil)
      assert_nil questionnaire.acc_status_author
    end

    should "return nil if author deleted" do
      user = create(:user, email: "director@example.com")
      questionnaire = create(:questionnaire, acc_status_author_id: user.id)
      user.destroy
      assert_nil questionnaire.acc_status_author
    end

    should "return the questionnaire's user" do
      user = create(:user, email: "director@example.com")
      questionnaire = create(:questionnaire, acc_status_author_id: user.id)
      assert_equal "director@example.com", questionnaire.acc_status_author.email
    end
  end

  context "#clean_negative_special_needs" do
    should "return nil if special_needs field is None" do
      questionnaire = create(:questionnaire, special_needs: "NoNE")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs field is n/a" do
      questionnaire = create(:questionnaire, special_needs: "N/a")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is non-applicable" do
      questionnaire = create(:questionnaire, special_needs: "Non-applicable")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is na" do
      questionnaire = create(:questionnaire, special_needs: "na")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is nothing" do
      questionnaire = create(:questionnaire, special_needs: "nOthing")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is nil" do
      questionnaire = create(:questionnaire, special_needs: "Nil")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is null" do
      questionnaire = create(:questionnaire, special_needs: "nULL")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is no" do
      questionnaire = create(:questionnaire, special_needs: "no")
      assert_nil questionnaire.special_needs
    end

    should "return nil if special_needs fiels is no (with spaces)" do
      questionnaire = create(:questionnaire, special_needs: " no ")
      assert_nil questionnaire.special_needs
    end

    should "return value if special_needs is none except for wheelchair" do
      questionnaire = create(:questionnaire, special_needs: "None except for wheelchair")
      assert_equal "None except for wheelchair", questionnaire.special_needs
    end

    should "return value if special_needs is no thank you" do
      questionnaire = create(:questionnaire, special_needs: "no thank you")
      assert_equal "no thank you", questionnaire.special_needs
    end

    should "return value if special_needs is need i need to sleep" do
      questionnaire = create(:questionnaire, special_needs: "I need to sleep")
      assert_equal "I need to sleep", questionnaire.special_needs
    end
  end

  context "#clean_negative_dietary_restrictions" do
    should "return nil if dietary_restrictions field is None" do
      questionnaire = create(:questionnaire, dietary_restrictions: "NoNE")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions field is n/a" do
      questionnaire = create(:questionnaire, dietary_restrictions: "N/a")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions field is non-applicable" do
      questionnaire = create(:questionnaire, dietary_restrictions: "Non-applicable")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions fiels is na" do
      questionnaire = create(:questionnaire, dietary_restrictions: "na")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions fiels is nothing" do
      questionnaire = create(:questionnaire, dietary_restrictions: "nOthing")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions fiels is nil" do
      questionnaire = create(:questionnaire, dietary_restrictions: "Nil")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions fiels is null" do
      questionnaire = create(:questionnaire, dietary_restrictions: "nULL")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions fiels is no" do
      questionnaire = create(:questionnaire, dietary_restrictions: "no")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return nil if dietary_restrictions fiels is no (with spaces)" do
      questionnaire = create(:questionnaire, dietary_restrictions: " no ")
      assert_nil questionnaire.dietary_restrictions
    end

    should "return value if dietary_restrictions is nothing except for peanuts" do
      questionnaire = create(:questionnaire, dietary_restrictions: "Nothing except for peanuts")
      assert_equal "Nothing except for peanuts", questionnaire.dietary_restrictions
    end

    should "return value if dietary_restrictions is no thank you" do
      questionnaire = create(:questionnaire, dietary_restrictions: "no thank you")
      assert_equal "no thank you", questionnaire.dietary_restrictions
    end

    should "return value if dietary_restrictions is need i am a vegetarian" do
      questionnaire = create(:questionnaire, dietary_restrictions: "I am a vegetarian")
      assert_equal "I am a vegetarian", questionnaire.dietary_restrictions
    end
  end

  context "#minor?" do
    should "return true for 16 year old" do
      HackathonConfig['event_start_date'] = "2020-06-12"
      questionnaire = create(:questionnaire, date_of_birth: Date.new(2004, 1, 1))
      assert questionnaire.minor?
    end

    should "return true for 17 year, 12 month, 30 day old" do
      HackathonConfig['event_start_date'] = "2020-06-12"
      questionnaire = create(:questionnaire, date_of_birth: Date.new(2002, 6, 13))
      assert_equal true, questionnaire.minor?
    end

    should "return false for 18 year old" do
      HackathonConfig['event_start_date'] = "2020-06-12"
      questionnaire = create(:questionnaire, date_of_birth: Date.new(2002, 6, 12))
      assert_equal false, questionnaire.minor?
    end

    should "return false for 20 year old" do
      HackathonConfig['event_start_date'] = "2020-06-12"
      questionnaire = create(:questionnaire, date_of_birth: Date.new(2000, 1, 1))
      assert_equal false, questionnaire.minor?
    end
  end

  context "#can_rsvp?" do
    should "return true for accepted questionnaires" do
      questionnaire = create(:questionnaire, acc_status: "accepted")
      assert questionnaire.can_rsvp?
      questionnaire.acc_status = "rsvp_confirmed"
      assert questionnaire.can_rsvp?
      questionnaire.acc_status = "rsvp_denied"
      assert questionnaire.can_rsvp?
    end

    should "return false for non-accepted questionnaires" do
      questionnaire = create(:questionnaire, acc_status: "denied")
      assert !questionnaire.can_rsvp?
    end
  end

  context "#did_rsvp?" do
    should "return true for confirmed & denied questionnaires" do
      questionnaire = create(:questionnaire)
      ['rsvp_confirmed', 'rsvp_denied'].each do |status|
        questionnaire.acc_status = status
        assert questionnaire.did_rsvp?
      end
    end

    should "return false for non-RSVP'd questionnaires" do
      questionnaire = create(:questionnaire)
      ['pending', 'accepted', 'denied', 'waitlist', 'late_waitlist'].each do |status|
        questionnaire.acc_status = status
        assert !questionnaire.did_rsvp?
      end
    end
  end

  context "#checked_in_by" do
    should "return nil if not checked in" do
      questionnaire = create(:questionnaire)
      assert_nil questionnaire.checked_in_by
      assert_nil questionnaire.checked_in_by_id
    end

    should "return nil if user who checked-in questionnaire is deleted" do
      user = create(:user)
      questionnaire = create(:questionnaire, checked_in_by_id: user.id)
      user.destroy
      assert_nil questionnaire.checked_in_by
    end

    should "return user who checked in ther questionnaire" do
      user = create(:user)
      questionnaire = create(:questionnaire, checked_in_by_id: user.id)
      assert_equal user.id, questionnaire.checked_in_by.id
      assert_equal user.id, questionnaire.checked_in_by_id
    end
  end

  context "#fips_code" do
    should "return fips code" do
      school = create(:school, city: "Rochester", state: "NY")
      create(:fips, fips_code: "36055", city: "Rochester", state: "NY")
      questionnaire = create(:questionnaire, school: school)
      assert_equal "36055", questionnaire.fips_code.fips_code
    end

    should "return null if no fips code" do
      school = create(:school, city: "Not Found", state: "NF")
      create(:fips, fips_code: "36055", city: "Rochester", state: "NY")
      questionnaire = create(:questionnaire, school: school)
      assert_nil questionnaire.fips_code
    end
  end

  context "#consolidate_school_names" do
    should "consolidate duplicate school names" do
      school = create(:school, name: "My School", city: "Rochester", state: "NY")
      bad_school = create(:school, name: "The My School")
      create(:school_name_duplicate, name: "The My School", school: school)

      questionnaire = create(:questionnaire, school: bad_school)
      assert_equal "My School", questionnaire.school.name
      assert_equal 1, school.reload.questionnaire_count
      assert_equal 0, bad_school.reload.questionnaire_count
    end
  end

  context "#queue_triggered_email" do
    should "send triggered email for accepted status" do
      questionnaire = create(:questionnaire, acc_status: 'pending')
      create(:message, trigger: "questionnaire.accepted")
      # Two messages that shouldn't be triggered
      create(:message, trigger: "questionnaire.pending")
      create(:message, trigger: "questionnaire.waitlist")
      assert_difference "enqueued_jobs.size", 1 do
        questionnaire.update_attribute(:acc_status, "accepted")
      end
    end

    should "not send triggered email for same acceptance status" do
      questionnaire = create(:questionnaire, acc_status: 'accepted')
      create(:message, trigger: "questionnaire.accepted")
      assert_difference "enqueued_jobs.size", 0 do
        questionnaire.update_attribute(:acc_status, "accepted")
      end
    end

    should "not send triggered email different changed value" do
      questionnaire = create(:questionnaire, acc_status: 'accepted')
      create(:message, trigger: "questionnaire.accepted")
      assert_difference "enqueued_jobs.size", 0 do
        questionnaire.update_attribute(:interest, "code")
      end
    end

    should "send triggered email for other statuses" do
      questionnaire = create(:questionnaire, acc_status: 'rsvp_denied')
      Questionnaire::POSSIBLE_ACC_STATUS.each do |acc_status, _|
        create(:message, trigger: "questionnaire.#{acc_status}")
      end
      Questionnaire::POSSIBLE_ACC_STATUS.each do |acc_status, _|
        assert_difference "enqueued_jobs.size", 1 do
          questionnaire.update_attribute(:acc_status, acc_status)
        end
      end
    end

    should "send triggered email on creation" do
      create(:message, trigger: "questionnaire.pending")
      assert_difference "enqueued_jobs.size", 2 do
        create(:questionnaire, acc_status: "pending")
      end
    end

    should "send triggered email on checked in" do
      create(:message, trigger: "questionnaire.checked-in")
      assert_difference "enqueued_jobs.size", 1 do
        create(:questionnaire, checked_in_at: Time.now)
      end
    end

    should "not send triggered email on checked out" do
      create(:message, trigger: "questionnaire.checked-in")
      questionnaire = create(:questionnaire, checked_in_at: Time.now)
      assert_difference "enqueued_jobs.size", 0 do
        questionnaire.update_attribute(:checked_in_at, nil)
      end
    end
  end

  should "clean up bus-related fields when changing RSVP" do
    bus_list = create(:bus_list)
    questionnaire = create(:questionnaire, acc_status: 'rsvp_confirmed', bus_list: bus_list, is_bus_captain: true, bus_captain_interest: true)
    questionnaire.acc_status = 'rsvp_denied'
    questionnaire.save
    assert_nil questionnaire.bus_list_id
    assert_equal false, questionnaire.is_bus_captain
    assert_equal false, questionnaire.bus_captain_interest
  end
end
