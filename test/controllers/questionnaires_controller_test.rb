require 'test_helper'
require 'minitest/mock'

class QuestionnairesControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @school = create(:school, name: "Another School")
    @questionnaire = create(:questionnaire, school_id: @school.id)
  end

  context "while not authenticated" do
    should "not show questionnaire" do
      get :show, format: :json
      assert_response :unauthorized
    end

    should "redirect to sign up page on questionnaire#update" do
      patch :update, params: { questionnaire: { major: "different" } }
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#destroy" do
      assert_difference('Questionnaire.count', 0) do
        delete :destroy
      end
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated without a completed questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:director]
      @user = create(:user)
      sign_in @user
    end

    should "not get a questionnaire" do
      get :show, format: :json
      assert_response :not_found
    end

    should "create questionnaire" do
      assert_difference('Questionnaire.count', 1) do
        post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
      end

      assert_response :created
      if HackathonConfig['auto_late_waitlist']
        assert_equal "late_waitlist", assigns(:questionnaire).acc_status
      else
        assert_equal "pending", assigns(:questionnaire).acc_status
      end
    end

    should "not allow multiple questionnaires" do
      assert_difference('Questionnaire.count', 1) do
        post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
        post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
      end

      assert_response :conflict
    end

    context "with an invalid questionnaire" do
      should "not allow creation" do
        @questionnaire.delete
        assert_difference('Questionnaire.count', 0) do
          post :create, params: { questionnaire: { major: "a great major" } }
        end
      end
    end

    context "with block questionnaires set" do
      should "not allow creation" do
        HackathonConfig['accepting_questionnaires'] = false
        assert_difference('Questionnaire.count', 0) do
          post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
        end
      end
    end

    context "#school_name" do
      context "on create" do
        should "save existing school name" do
          post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: @school.name, major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
          assert_response :created
          assert_equal 1, School.all.count
        end

        should "create a new school when unknown" do
          post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: "New School", major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
          assert_response :created
          assert_equal 2, School.all.count
        end

        should "send confirmation email to questionnaire" do
          message = create(:message, type: 'automated', trigger: "questionnaire.pending")
          assert_difference 'enqueued_jobs.size', 1 do
            assert_difference 'Questionnaire.count', 1 do
              post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, country: @questionnaire.country, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: @school.name, major: @questionnaire.major, gender: @questionnaire.gender, why_attend: @questionnaire.why_attend, graduation_year: @questionnaire.graduation_year, race_ethnicity: @questionnaire.race_ethnicity, agreement_ids: @questionnaire.agreements.map(&:id) } }
            end
          end
          questionnaire = Questionnaire.last
          job = enqueued_jobs.last
          args = job[:args]
          job_name_arg = args[1]
          message_id_arg = args[3]
          user_id_arg = args[4]

          assert_equal "bulk_message_email", job_name_arg, "expected correct job name in job args"
          assert_equal message.id, message_id_arg, "expected correct message ID in job args"
          assert_equal questionnaire.user_id, user_id_arg, "expected correct user ID in job args"
        end
      end
    end

    context "not accepting questionnaires" do
      setup do
        HackathonConfig['accepting_questionnaires'] = false
      end

      should "not allow questionnaire to be created" do
        assert_difference('Questionnaire.count', 0) do
          post :create, params: { questionnaire: { experience: @questionnaire.experience,
                                                   interest: @questionnaire.interest,
                                                   country: @questionnaire.country,
                                                   phone: @questionnaire.phone,
                                                   level_of_study: @questionnaire.level_of_study,
                                                   date_of_birth: @questionnaire.date_of_birth,
                                                   shirt_size: @questionnaire.shirt_size,
                                                   school_id: @school.id,
                                                   major: @questionnaire.major,
                                                   gender: @questionnaire.gender,
                                                   why_attend: @questionnaire.why_attend,
                                                   graduation_year: @questionnaire.graduation_year,
                                                   race_ethnicity: @questionnaire.race_ethnicity,
                                                   agreement_ids: @questionnaire.agreements.map(&:id) } }
        end

        assert_response :not_acceptable
      end
    end
  end

  context "while authenticated with a completed questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @questionnaire.user
    end

    should "show questionnaire" do
      get :show, format: :json
      assert_response :success
    end

    should "update questionnaire" do
      patch :update, params: { questionnaire: { major: "Computer Science" } }
      assert_response :success
    end

    context "destroy questionnaire" do
      should "if bus captain, notify directors that bus captain has been removed" do
        @director = create(:director)
        @questionnaire.update_attribute(:is_bus_captain, true)
        assert_difference('enqueued_jobs.size', User.where(role: :director).size) do
          delete :destroy
        end
        assert_response :ok
      end

      should "user destroy questionnaire" do
        assert_difference('Questionnaire.count', -1) do
          delete :destroy
        end
        assert_response :ok
      end
    end

    context "with invalid questionnaire params" do
      should "not allow updates" do
        saved_major = @questionnaire.major
        patch :update, params: { questionnaire: { major: "" } }
        assert_equal saved_major, @questionnaire.reload.major
      end
    end

    context "#school_name" do
      context "on update" do
        should "save existing school name" do
          patch :update, params: { questionnaire: { school_name: @school.name } }
          assert_response :accepted
          assert_equal 1, School.all.count
        end

        should "create a new school when unknown" do
          patch :update, params: { questionnaire: { school_name: "New School" } }
          assert_response :accepted
          assert_equal 2, School.all.count
        end
      end
    end

    context "#schools" do
      should "not respond to search with no query" do
        get :schools
        assert_response 400
        assert @response.body.blank?
      end

      should "not respond to search with short query" do
        get :schools, params: { school: "Al" }
        assert_response 400
        assert @response.body.blank?
      end

      should "respond to school search" do
        create(:school, name: "Alpha University")
        create(:school, name: "Pheta College")
        get :schools, params: { name: "Alph" }
        assert_response :success
        assert_equal 1, json_response.count
        assert_equal "Alpha University", json_response[0]
      end

      should "prioritize schools with more applicants" do
        create(:school, name: "Alpha College", questionnaire_count: 0)
        create(:school, name: "Pheta College", questionnaire_count: 5)
        get :schools, params: { name: "Coll" }
        assert_response :success
        assert_equal "Pheta College", json_response[0]
      end
    end
  end

  private

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
