class MessageDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_message_path

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
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_message_path(record)),
        id: record.id,
        name: record.name,
        subject: record.subject,
        trigger: record.trigger,
        status: record.status.titleize,
        delivered_at: record.delivered_at.present? ? record.delivered_at.strftime("%B %d, %Y at %I:%M %p") : ''
      }
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    Message.unscoped
  end
end
