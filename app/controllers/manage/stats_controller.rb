class Manage::StatsController < Manage::ApplicationController
  def index
  end

  def dietary_special_needs
    data = Rails.cache.fetch(cache_key_for_questionnaires("dietary_special_needs")) do

      # Condition: only retrieve users that have dietary restrictions or special dietary needs
      restrictions = "acc_status = 'rsvp_confirmed' AND "\
                     "dietary_restrictions != '' OR special_needs != ''"

      # Filter for the values we want to show to the model
      q_attributes = [
        :major,
        :phone,
        :checked_in_at,
        :dietary_restrictions,
        :special_needs,
        :gender
      ]

      # Generate a full "request" (relation) based on this
      q_request = Questionnaire.where(restrictions)
      q_json = q_request.select(q_attributes).as_json

      q_request.each_with_index do |request, index|
        q_json[index]["first_name"] = request.user.first_name
        q_json[index]["last_name"]  = request.user.last_name
        q_json[index]["email"]      = request.user.email
      end

      q_json
    end

    # Finally, render it out
    render json: {
      data: data,
      recordsTotal: Questionnaire.count,
      recordsFiltered: data.count
    }
  end

  def alt_travel
    data = Rails.cache.fetch(cache_key_for_questionnaires("alt_travel")) do

      # User info is taken from user model, not from questionnaire query
      q_attributes = [
        :id,
        :travel_location,
        :acc_status
      ]

      restrictions = "travel_not_from_school = '1'"

      q_request = Questionnaire.where(restrictions)
      q_json = q_request.select(q_attributes).as_json

      q_request.each_with_index do |request, index|
        q_json[index]["first_name"] = request.user.first_name
        q_json[index]["last_name"]  = request.user.last_name
        q_json[index]["email"]      = request.user.email
        q_json[index]["questionnaire_link"] = view_context.link_to("View &raquo;".html_safe, manage_questionnaire_path(request))
      end

      q_json
    end
    render json: {
      data: data,
      recordsTotal: Questionnaire.count,
      recordsFiltered: data.count
    }
  end


  def sponsor_info
    data = Rails.cache.fetch(cache_key_for_questionnaires("sponsor_info")) do

      # User info is taken from user model, not from questionnaire query
      # (also school name)
      q_attributes = [
        :id,
        :vcs_url,
        :portfolio_url
      ]

      restrictions = "can_share_info = '1' AND checked_in_at != 0"

      q_request = Questionnaire.where(restrictions)
      q_json = q_request.select(q_attributes).as_json

      q_request.each_with_index do |request, index|
        q_json[index]["first_name"]  = request.user.first_name
        q_json[index]["last_name"]   = request.user.last_name
        q_json[index]["email"]       = request.user.email
        q_json[index]["school_name"] = request.school_name
      end

      q_json
    end
    render json: {
      data: data,
      recordsTotal: Questionnaire.count,
      recordsFiltered: data.count
    }
  end

  def mlh_info_applied
    data = Rails.cache.fetch(cache_key_for_questionnaires("mlh_info_applied")) do

      # User info is taken from user model, not from questionnaire query
      # (also school name)
      q_attributes = [
        :id
      ]

      q_request = Questionnaire.joins(:school)
      q_json = q_request.select(q_attributes).as_json

      q_request.each_with_index do |request, index|
        q_json[index]["first_name"]  = request.user.first_name
        q_json[index]["last_name"]   = request.user.last_name
        q_json[index]["email"]       = request.user.email
        q_json[index]["school_name"] = request.school_name
      end

      q_json
    end
    render json: {
      data: data,
      recordsTotal: Questionnaire.count,
      recordsFiltered: data.count
    }
  end

  def mlh_info_checked_in
    data = Rails.cache.fetch(cache_key_for_questionnaires("mlh_info_checked_in")) do
      # User info is taken from user model, not from questionnaire query
      # (also school name)
      q_attributes = [
        :id
      ]

      restrictions = "checked_in_at > 0"

      q_request = Questionnaire.joins(:school).where(restrictions)
      q_json = q_request.select(q_attributes).as_json

      q_request.each_with_index do |request, index|
        q_json[index]["first_name"]  = request.user.first_name
        q_json[index]["last_name"]   = request.user.last_name
        q_json[index]["email"]       = request.user.email
        q_json[index]["school_name"] = request.school_name
      end

      q_json
    end
    render json: {
      data: data,
      recordsTotal: Questionnaire.count,
      recordsFiltered: data.count
    }
  end

  private

  def to_json_array(data, attributes)
    data.map { |e| attributes.map { |a| e.send(a) } }
  end

  def cache_key_for_questionnaires(id)
    count          = Questionnaire.count
    max_updated_at = Questionnaire.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "stats/all-#{count}-#{max_updated_at}-#{id}"
  end
end
