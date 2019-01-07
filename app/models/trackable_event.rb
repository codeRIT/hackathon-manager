class TrackableEvent < ApplicationRecord
  belongs_to :trackable_tag
  belongs_to :user
end
