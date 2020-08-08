class IndividualMessageDatatable < AjaxDatatablesRails::ActiveRecord
  def_delegators :@view, :link_to, :manage_message_path, :manage_individual_message_path

  def view_columns
    @view_columns ||= {
      id: { source: "IndividualMessage.id" },
      name: { source: "IndividualMessage.name" },
      subject: { source: "IndividualMessage.subject" },
      recipient: { source: "IndividualMessage.recipient" },
      started_at: { source: "IndividualMessage.started_at", searchable: false },
      delivered_at: { source: "IndividualMessage.delivered_at", searchable: false },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        subject: record.subject,
        recipient: record.recipient,
        started_at: record.started_at,
        delivered_at: record.delivered_at,
      }
    end
  end

  def get_raw_records
    IndividualMessage.all
  end

end
