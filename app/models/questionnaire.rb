class Questionnaire < ApplicationRecord
  audited

  include ActiveModel::Dirty
  include DeletableAttachment

  before_validation :consolidate_school_names
  before_validation :clean_for_non_rsvp
  before_validation :clean_negative_special_needs
  before_validation :clean_negative_dietary_restrictions
  after_create :queue_triggered_email_create
  after_update :queue_triggered_email_update
  after_update :queue_triggered_email_rsvp_reminder
  after_update :queue_triggered_email_checked_in
  after_save :update_school_questionnaire_count
  after_destroy :update_school_questionnaire_count

  belongs_to :user
  belongs_to :school
  belongs_to :bus_list, optional: true

  validates_uniqueness_of :user_id

  validates_presence_of :phone, :date_of_birth, :school_id, :experience, :shirt_size, :interest
  validates_presence_of :gender, :major, :level_of_study, :graduation_year, :race_ethnicity
  validates_presence_of :agreement_accepted, message: "Please read & accept"
  validates_presence_of :code_of_conduct_accepted, message: "Please read & accept"
  validates_presence_of :data_sharing_accepted, message: "Please read & accept"

  DIETARY_SPECIAL_NEEDS_MAX_LENGTH = 500
  validates_length_of :dietary_restrictions, maximum: DIETARY_SPECIAL_NEEDS_MAX_LENGTH
  validates_length_of :special_needs, maximum: DIETARY_SPECIAL_NEEDS_MAX_LENGTH

  # if HackathonManager.field_enabled?(:why_attend)
  #   validates_presence_of :why_attend
  # end

  has_one_attached :resume
  deletable_attachment :resume
  validates :resume, file_size: { less_than_or_equal_to: 2.megabytes },
                     file_content_type: { allow: ['application/pdf'] },
                     if: -> { resume.attached? }

  validates :portfolio_url, url: { allow_blank: true }
  validates :vcs_url, url: { allow_blank: true }
  validates_format_of :vcs_url, with: %r{((github.com\/\w+\/?)|(bitbucket.org\/\w+\/?))}, allow_blank: true, message: "Must be a GitHub or BitBucket url"

  serialize :extra_question_data, Hash
  validates_each :extra_question_data do |record, attr, value|
    problems = ''
    value.each do |q, a|
      extra_question = ExtraQuestion.find(q)
      puts(extra_question.required)
      puts(a.presence)
      if extra_question.required && a.blank?
        problems += "#{extra_question.question} can not be blank"
      end
    end
    record.errors.add(:extra_question_data, problems) unless problems.empty?
  end

  strip_attributes

  POSSIBLE_EXPERIENCES = {
    "first"       => "This is my 1st hackathon!",
    "experienced" => "My feet are wet. (1-5 hackathons)",
    "expert"      => "I'm a veteran hacker. (6+ hackathons)"
  }.freeze

  POSSIBLE_INTERESTS = {
    "design"      => "Design",
    "software"    => "Software",
    "hardware"    => "Hardware",
    "combination" => "Combination of everything!"
  }.freeze

  # POSSIBLE_QUESTION_TYPES = %w[string boolean integer date datetime binary decimal float bigint text time timestamp].freeze

  POSSIBLE_SHIRT_SIZES = [
    "Women's - XS",
    "Women's - S",
    "Women's - M",
    "Women's - L",
    "Women's - XL",
    "Unisex - XS",
    "Unisex - S",
    "Unisex - M",
    "Unisex - L",
    "Unisex - XL"
  ].freeze

  POSSIBLE_ACC_STATUS = {
    "pending"        => "Pending Review",
    "accepted"       => "Accepted",
    "waitlist"       => "Waitlisted",
    "denied"         => "Denied",
    "late_waitlist"  => "Waitlisted, Late",
    "rsvp_confirmed" => "RSVP Confirmed",
    "rsvp_denied"    => "RSVP Denied"
  }.freeze

  POSSIBLE_GRAD_YEARS = (Date.today.year - 3...Date.today.year + 7).to_a.freeze

  POSSIBLE_RACE_ETHNICITIES = [
    "American Indian or Alaskan Native",
    "Asian / Pacific Islander",
    "Black or African American",
    "Hispanic",
    "White / Caucasian",
    "Multiple ethnicities / Other",
    "Prefer not to answer"
  ].freeze

  # From My MLH's dropdown list.
  # Should *not* validate against this list in case My MLH changes their options,
  # as this would cause errors until a manual gem update
  POSSIBLE_GENDERS = [
    "Female",
    "Male",
    "Non-Binary",
    "I prefer not to say",
    "Other"
  ].freeze

  # From My MLH's dropdown list.
  # Should *not* validate against this list in case My MLH changes their options,
  # as this would cause errors until a manual gem update
  POSSIBLE_LEVELS_OF_STUDY = [
    "Elementary / Middle School / Primary School",
    "High School / Secondary School",
    "University (Undergraduate)",
    "University (Master's / Doctoral)",
    "Vocational / Code School",
    "Not Currently a Student",
    "Other"
  ].freeze

  validates_inclusion_of :experience, in: POSSIBLE_EXPERIENCES
  validates_inclusion_of :interest, in: POSSIBLE_INTERESTS
  # validates_inclusion_of :school_id, :in => School.select(:id)
  validates_inclusion_of :shirt_size, in: POSSIBLE_SHIRT_SIZES
  validates_inclusion_of :acc_status, in: POSSIBLE_ACC_STATUS

  def email
    user&.email
  end

  def portfolio_url=(value)
    value = "http://" + value if !value.blank? && !value.include?("http://") && !value.include?("https://")
    super value
  end

  def vcs_url=(value)
    value = "http://" + value if !value.blank? && !value.include?("http://") && !value.include?("https://")
    super value
  end

  def phone=(value)
    # strips the string to just numbers for standardization
    value = value.try(:tr, '^0-9', '')
    super value
  end

  def school
    School.find(school_id) if school_id
  end

  def school_name
    school.name if school_id
  end

  def full_location
    "#{school.city}, #{school.state}"
  end

  def date_of_birth_formatted
    date_of_birth.strftime("%B %-d, %Y")
  end

  def acc_status_author
    return unless acc_status_author_id.present?
    User.find_by_id(acc_status_author_id)
  end

  def checked_in?
    checked_in_at.present?
  end

  def boarded_bus?
    boarded_bus_at.present?
  end

  def checked_in_by
    return unless checked_in_by_id.present?
    User.find_by_id(checked_in_by_id)
  end

  def fips_code
    Fips.where(city: school.city, state: school.state).first
  end

  def age_at_time_of_event
    (Date.parse(HackathonConfig['event_start_date']) - date_of_birth).to_i * 1.day
  end

  def minor?
    age_at_time_of_event < 18.years
  end

  def can_rsvp?
    ["accepted", "rsvp_confirmed", "rsvp_denied"].include? acc_status
  end

  def did_rsvp?
    ['rsvp_confirmed', 'rsvp_denied'].include? acc_status
  end

  def verbal_status
    if acc_status == "rsvp_denied"
      "Not Attending"
    elsif acc_status == "rsvp_confirmed"
      "Accepted & Attending"
    elsif acc_status == "accepted"
      "Accepted, Awaiting RSVP"
    elsif acc_status == "pending"
      "Pending Review"
    elsif ["waitlist", "late_waitlist"].include? acc_status
      "Waitlisted"
    elsif acc_status == "denied"
      "Denied"
    end
  end

  private

  def clean_for_non_rsvp
    if acc_status != "rsvp_confirmed"
      self.bus_list_id = nil
      self.is_bus_captain = false
      self.bus_captain_interest = false
    end
  end

  def clean_negative_special_needs
    self.special_needs = nil if special_needs.present? && %w[none n/a non-applicable na nothing nil null no].include?(special_needs.strip.downcase)
  end

  def clean_negative_dietary_restrictions
    self.dietary_restrictions = nil if dietary_restrictions.present? && %w[none n/a non-applicable na nothing nil null no].include?(dietary_restrictions.strip.downcase)
  end

  def consolidate_school_names
    return if school.blank?
    duplicate = SchoolNameDuplicate.find_by(name: school.name)
    return if duplicate.blank?
    self.school_id = duplicate.school_id
  end

  def update_school_questionnaire_count
    if destroyed?
      School.decrement_counter(:questionnaire_count, school_id)
    elsif saved_change_to_school_id?
      old_school_id = saved_changes['school_id'].first
      School.decrement_counter(:questionnaire_count, old_school_id) if old_school_id.present?
      School.increment_counter(:questionnaire_count, school_id)
    end
  end

  def queue_triggered_email_update
    Message.queue_for_trigger("questionnaire.#{acc_status}", user_id) if saved_change_to_acc_status?
  end

  def queue_triggered_email_create
    Message.queue_for_trigger("questionnaire.#{acc_status}", user_id)
  end

  def queue_triggered_email_checked_in
    return unless saved_change_to_checked_in_at && checked_in?
    Message.queue_for_trigger("questionnaire.checked-in", user_id)
  end

  def queue_triggered_email_rsvp_reminder
    return unless saved_change_to_acc_status? && acc_status == "accepted"

    event_start = Date.parse(HackathonConfig["event_start_date"]).in_time_zone
    days_remaining = event_start.to_date - Time.now.in_time_zone.to_date
    if days_remaining > 14
      deliver_date = 7.days.from_now
    elsif days_remaining > 10
      deliver_date = 5.days.from_now
    elsif days_remaining > 3
      deliver_date = 2.days.from_now
    end
    UserMailer.rsvp_reminder_email(user_id).deliver_later(wait_until: deliver_date) if deliver_date.present?
  end
end
