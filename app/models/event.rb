class Event < ApplicationRecord
  validates_presence_of :title, :start, :end
  before_save :empty_string_owners

  serialize :owner, Array

  def owners_list
    labels = recipients.map do |r|
      if r.match? /(.*)::(\d*)/
        EventOwnerQuery.friendly_name(r)
      else
        "(unknown)"
      end
    end
    labels
  end

  def empty_string_owners
    owner.delete_if(&:empty?)
  end

  def possible_owners
    option = ->(query, model) { [EventOwnerQuery.friendly_name(query, model), query] }
    admin_list = User.where(role: :admin).map do |user|
      option.call("user::#{user.id}", user)
    end

    admin_list
  end
end
