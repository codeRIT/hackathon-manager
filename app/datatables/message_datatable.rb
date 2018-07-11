class MessageDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_message_path, :display_datetime

  def view_columns
    @view_columns ||= {
      id: { source: "Message.id" },
      name: { source: "Message.name" },
      subject: { source: "Message.subject" },
      trigger: { source: "Message.trigger" },
      delivered_at: { source: "Message.delivered_at", searchable: false }
    }
  end

  private

  def data
    records.map do |record|
      {
        id: record.id,
        name: link_to(record.name, manage_message_path(record)),
        subject: record.subject,
        trigger: Message::POSSIBLE_TRIGGERS[record.trigger],
        status: record.status.titleize,
        delivered_at: record.delivered_at.present? ? display_datetime(record.delivered_at) : ''
      }
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    Message.unscoped
  end
end
