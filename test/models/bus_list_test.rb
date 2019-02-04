require 'test_helper'

class BusListTest < ActiveSupport::TestCase
  should strip_attribute :name
  should strip_attribute :notes

  should validate_presence_of :name
  should validate_presence_of :capacity
  should validate_uniqueness_of :name

  should have_many :questionnaires

  context "#passengers" do
    setup do
      @bus_list = create(:bus_list)
    end

    should "return all passengers" do
      questionnaire1 = create(:questionnaire, bus_list_id: @bus_list.id, acc_status: "rsvp_confirmed")
      questionnaire2 = create(:questionnaire, bus_list_id: @bus_list.id, acc_status: "rsvp_confirmed")
      assert_equal 2, @bus_list.passengers.count
      allowed_ids = [questionnaire1, questionnaire2].map(&:id)
      assert allowed_ids.include? @bus_list.passengers[0].id
      assert allowed_ids.include? @bus_list.passengers[1].id
    end

    should "only return passengers who have RSVP'd" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id)
      Questionnaire::POSSIBLE_ACC_STATUS.each do |status, _title|
        next if status == "rsvp_confirmed"
        create(:questionnaire, acc_status: status, bus_list_id: @bus_list.id)
      end
      assert_equal 1, @bus_list.passengers.count
      assert_equal questionnaire1.id, @bus_list.passengers[0].id
    end

    should "not return passengers from another bus" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id)
      bus_list2 = create(:bus_list)
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: bus_list2.id)
      assert_equal 1, @bus_list.passengers.count
      assert_equal questionnaire1.id, @bus_list.passengers[0].id
    end
  end

  context "#boarded_passengers" do
    setup do
      @bus_list = create(:bus_list)
    end

    should "return all boarded passengers" do
      questionnaire1 = create(:questionnaire, bus_list_id: @bus_list.id, acc_status: "rsvp_confirmed", boarded_bus_at: nil)
      questionnaire2 = create(:questionnaire, bus_list_id: @bus_list.id, acc_status: "rsvp_confirmed", boarded_bus_at: Time.now)
      questionnaire3 = create(:questionnaire, bus_list_id: @bus_list.id, acc_status: "rsvp_confirmed", boarded_bus_at: Time.now)
      assert_equal 2, @bus_list.boarded_passengers.count
      allowed_ids = [questionnaire2, questionnaire3].map(&:id)
      assert allowed_ids.include? @bus_list.boarded_passengers[0].id
      assert allowed_ids.include? @bus_list.boarded_passengers[1].id
    end
  end

  context "#checked_in_passengers" do
    setup do
      @bus_list = create(:bus_list)
    end

    should "be empty if no passengers" do
      assert_equal 0, @bus_list.checked_in_passengers.count
    end

    should "only return passengers who have checked in" do
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id, checked_in_at: 2.minutes.ago)
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id, checked_in_at: nil)
      assert_equal 2, @bus_list.passengers.count
      assert_equal 1, @bus_list.checked_in_passengers.count
    end
  end

  context "#captians" do
    setup do
      @bus_list = create(:bus_list)
    end

    should "return all captains" do
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id)
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id)
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id, is_bus_captain: true)
      questionnaire2 = create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id, is_bus_captain: true)
      create(:questionnaire, acc_status: "rsvp_confirmed")
      assert_equal 2, @bus_list.captains.count
      allowed_ids = [questionnaire1, questionnaire2].map(&:id)
      assert allowed_ids.include? @bus_list.captains[0].id
      assert allowed_ids.include? @bus_list.captains[1].id
    end

    should "only return captains who have RSVP'd" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id, is_bus_captain: true)
      Questionnaire::POSSIBLE_ACC_STATUS.each do |status, _title|
        next if status == "rsvp_confirmed"
        create(:questionnaire, acc_status: status, bus_list_id: @bus_list.id, is_bus_captain: true)
      end
      assert_equal 1, @bus_list.captains.count
      assert_equal questionnaire1.id, @bus_list.captains[0].id
    end

    should "not return captains from another bus" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: @bus_list.id, is_bus_captain: true)
      bus_list2 = create(:bus_list)
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: bus_list2.id, is_bus_captain: true)
      assert_equal 1, @bus_list.captains.count
      assert_equal questionnaire1.id, @bus_list.captains[0].id
    end
  end

  context "#name_maybe_full" do
    setup do
      @bus_list = build(:bus_list, name: "Foo", capacity: 1)
    end

    should "return normal name for not-full bus" do
      assert_equal "Foo", @bus_list.name_maybe_full
    end

    should "return (full) name for full bus" do
      @bus_list.update_attribute(:capacity, 0)
      assert_equal "(full) Foo", @bus_list.name_maybe_full
    end
  end
end
