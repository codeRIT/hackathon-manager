class Message < ApplicationRecord
  validates_presence_of :name, :subject, :template
  validates_presence_of :body, if: :using_default_template?

  strip_attributes

  POSSIBLE_TEMPLATES = ["default"].freeze

  POSSIBLE_TYPES = ["bulk", "automated"].freeze

  POSSIBLE_SIMPLE_RECIPIENTS = {
    "all"                              => "Everyone",
    "incomplete"                       => "Incomplete Applications",
    "complete"                         => "Complete Applications",
    "accepted"                         => "Accepted Applications",
    "denied"                           => "Denied Applications",
    "waitlisted"                       => "Waitlisted Applications",
    "late-waitlisted"                  => "Late, Waitlisted Applications",
    "rsvp-confirmed"                   => "RSVP Confirmed Attendees",
    "rsvp-denied"                      => "RSVP Denied Attendees",
    "checked-in"                       => "Checked-In Attendees",
    "non-checked-in"                   => "Non-Checked-In, Accepted & RSVP'd Applications",
    "non-checked-in-excluding"         => "Non-Checked-In Applications, Excluding Accepted & RSVP'd"
  }.freeze

  POSSIBLE_TRIGGERS = {
    "questionnaire.pending"        => "Questionnaire Status: Pending Review (new application)",
    "questionnaire.accepted"       => "Questionnaire Status: Accepted",
    "questionnaire.waitlist"       => "Questionnaire Status: Waitlisted",
    "questionnaire.denied"         => "Questionnaire Status: Denied",
    "questionnaire.late_waitlist"  => "Questionnaire Status: Waitlisted, Late",
    "questionnaire.rsvp_confirmed" => "Questionnaire Status: RSVP Confirmed",
    "questionnaire.rsvp_denied"    => "Questionnaire Status: RSVP Denied"
  }.freeze

  serialize :recipients, Array

  validates_inclusion_of :template, in: POSSIBLE_TEMPLATES
  validates_inclusion_of :type, in: POSSIBLE_TYPES

  def recipients=(values)
    values.present? ? super(values.reject(&:blank?)) : super(values)
  end

  def recipients_list
    labels = recipients.map do |r|
      if POSSIBLE_SIMPLE_RECIPIENTS.include?(r)
        POSSIBLE_SIMPLE_RECIPIENTS[r]
      elsif r.match? /(.*)::(\d*)/
        MessageRecipientQuery.friendly_name(r)
      else
        "(unknown)"
      end
    end
    labels
  end

  def bulk?
    type == "bulk"
  end

  def automated?
    type == "automated"
  end

  def delivered?
    delivered_at.present?
  end

  def started?
    started_at.present?
  end

  def queued?
    queued_at.present?
  end

  def status
    return "automated" if automated?
    return "delivered" if delivered?
    return "started" if started?
    return "queued" if queued?
    "drafted"
  end

  def can_edit?
    automated? || status == "drafted"
  end

  def can_queue?
    status == "drafted" && recipients_list.present?
  end

  def using_default_template?
    template == "default"
  end

  def possible_recipients
    # Produce an array like:
    # ["School: My University", "school::123"]
    option = ->(query, model) { [MessageRecipientQuery.friendly_name(query, model), query] }
    bus_list_recipients = BusList.select(:id, :name).map do |bus_list|
      [
        option.call("bus-list::#{bus_list.id}", bus_list),
        option.call("bus-list--eligible::#{bus_list.id}", bus_list),
        option.call("bus-list--applied::#{bus_list.id}", bus_list)
      ]
    end
    bus_list_recipients.flatten!(1) # Required since we have multiple options for each bus list

    school_recipients = School.select(:id, :name).map do |school|
      option.call("school::#{school.id}", school)
    end
    # No flatten needed here since each map returns a single option

    blazer_recipients = Blazer::Query.select(:id, :name).map do |query|
      option.call("blazer::#{query.id}", query)
    end
    # No flatten needed here since each map returns a single option

    # Combine all recipients. push(*recipients) is the most efficient,
    # as it doesn't create a new array each time (concat() does)
    recipients = POSSIBLE_SIMPLE_RECIPIENTS.invert.to_a
    recipients.push(*bus_list_recipients)
    recipients.push(*school_recipients)
    recipients.push(*blazer_recipients)

    # Add current recipients if not included
    self.recipients.each do |recipient|
      if recipients.none? { |recipient_pair| recipient_pair[1] == recipient }
        recipients.push([recipient, recipient])
      end
    end

    recipients
  end

  def self.queue_for_trigger(trigger, user_id)
    messages_to_queue = Message.where(trigger: trigger)
    messages_to_queue.map { |message| Mailer.delay.bulk_message_email(message.id, user_id) }
  end

  def self.bulk
    where(type: 'bulk')
  end

  def self.automated
    where(type: 'automated')
  end

  def self.inheritance_column
    "class_type"
  end
end
