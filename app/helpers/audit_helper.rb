module AuditHelper
  def display_audit_value(value, field)
    return "(none)" if value.blank?
    return Questionnaire::POSSIBLE_ACC_STATUS[value] if field == "acc_status"
    return BusList.find(value)&.name || value if field == "bus_list_id"
    return User.find(value)&.full_name || value if field == "checked_in_by_id"
    return value.join(", ") if value.is_a? Array
    return display_datetime(value, relative: false) if value.is_a? Time

    value
  end
end
