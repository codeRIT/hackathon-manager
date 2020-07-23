class IndividualMessage < ApplicationRecord
  validates_presence_of :name, :subject, :body, :recipient
end
