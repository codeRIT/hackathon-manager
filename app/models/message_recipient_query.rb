class MessageRecipientQuery
  class ModelIdNotFound < StandardError
  end

  attr_accessor :query
  attr_accessor :type
  attr_accessor :id
  attr_accessor :model

  def initialize(query, type, id, model)
    @query = query
    @type = type
    @id = id
    @model = model
  end

  def self.parse(query, model = nil)
    # Format:
    # model::ID
    # model--modifier::ID
    match = query.match(/(.*)::(\d*)/)
    type = match[1]
    id = match[2]

    # Find the backing database model, ensuring the given ID exists for that model.
    model_name = nil
    case type
    when "bus-list"
      model ||= BusList.find_by_id(id)
      model_name = "Bus List"
    when "school"
      model ||= School.find_by_id(id)
      model_name = "School"
    when "blazer"
      model ||= Blazer::Query.find_by_id(id)
      model_name = "Blazer Query"
    else
      raise "Unknown recipient query type: #{type.inspect} (in message recipient query: #{query.inspect}"
    end
    raise MessageRecipientQuery::ModelIdNotFound, "Could not find #{model_name} with ID #{id.inspect} (in message recipient query: #{query.inspect})" if model.blank?

    MessageRecipientQuery.new(
      query,
      type,
      id,
      model
    )
  end

  def self.friendly_name(query, model = nil)
    begin
      recipient_query = parse(query, model)
      model = recipient_query.model
    rescue MessageRecipientQuery::ModelIdNotFound
      return "[invalid recipient]"
    end

    case recipient_query.type
    when "bus-list"
      "Bus List: #{model.name} (signed up passengers)"
    when "school"
      "Confirmed or Accepted: #{model.name}"
    when "blazer"
      "Blazer Query: #{model.name}"
    else
      raise "Unknown recipient query type: #{recipient_query.type.inspect} (in message recipient query: #{r.inspect}"
    end
  end
end
