class IndividualMessageDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
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
        # example:
        # id: record.id,
        # name: record.name
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
    # insert query here
    # User.all
    IndividualMessage.all
  end

end
