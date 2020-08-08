class EventOwnerQuery
  class ModelIdNotFound < StandardError
  end

  attr_accessor :query
  attr_accessor :type
  attr_accessor :id
  attr_accessor :model

  def initialize(query, id, model)
    @query = query
    @id = id
    @model = model
  end

  def self.parse(query, model = nil)
    # Find the backing database model, ensuring the given ID exists for that model.
    # Format:
    # model::ID
    # model--modifier::ID
    match = query.match(/(.*)::(\d*)/)
    id = match[2]

    # Find the backing database model, ensuring the given ID exists for that model.
    model ||= User.find_by_id(id)

    EventOwnerQuery.new(
      query,
      id,
      model
    )
  end

  def self.friendly_name(query, model = nil)
    begin
      recipient_query = parse(query, model)
      model = recipient_query.model
    rescue EventOwnerQuery::ModelIdNotFound
      return "[invalid user]"
    end
    model.full_name
  end
end
