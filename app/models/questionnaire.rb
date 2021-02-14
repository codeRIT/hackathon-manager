class Questionnaire < ApplicationRecord
  audited

  attr_accessor :validate_switch

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
  has_and_belongs_to_many :agreements

  validates_uniqueness_of :user_id

  validates_presence_of :phone, :date_of_birth, :school_id, :experience, :shirt_size, :interest
  validates_presence_of :gender, :major, :level_of_study, :graduation_year, :race_ethnicity, :country

  DIETARY_SPECIAL_NEEDS_MAX_LENGTH = 500
  validates_length_of :dietary_restrictions, maximum: DIETARY_SPECIAL_NEEDS_MAX_LENGTH
  validates_length_of :special_needs, maximum: DIETARY_SPECIAL_NEEDS_MAX_LENGTH

  validate :agreements_present

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
  validates_format_of :vcs_url,
                      with: %r{\A((https?:\/\/)?(www\.)?((github\.com)|(gitlab\.com)|(bitbucket\.org))\/(.*){0,62})\z}i,
                      allow_blank: true,
                      message: "Must be a GitHub, GitLab or Bitbucket url"
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

  POSSIBLE_COUNTRIES = [
    "United States",
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo, Democratic Republic of the Congo",
    "Congo, Republic of the",
    "Costa Rica",
    "Cote d'Ivoire (Ivory Coast)",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Timor-Leste (East Timor)",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia, The",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, North",
    "Korea, South",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macedonia, North",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia and Montenegro",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
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
    value = value.downcase unless value.blank?
    value = "http://" + value if !value.blank? && !value.include?("http://") && !value.include?("https://")
    super value
  end

  def vcs_url=(value)
    value = value.downcase unless value.blank?
    value = "https://" + value if !value.blank? && !value.include?("http://") && !value.include?("https://")
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

  def agreements_present
    if (Agreement.all - agreements).any?
      errors.add(:agreements, "must be accepted.")
    end
  end

  def all_agreements_accepted?
    (Agreement.all - agreements).empty?
  end

  def unaccepted_agreements
    Agreement.all - agreements
  end

  def update_with_invalid_attributes(attributes)
    assign_attributes(attributes)
    save!(validate: false)
  end

  def as_json(options = {})
    result = super
    result['all_agreements_accepted'] = all_agreements_accepted?
    result
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
