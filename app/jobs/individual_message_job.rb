class IndividualMessageJob < ApplicationJob
  queue_as :default

  def perform(individual_message)
    individual_message.update_attribute(:started_at, Time.now)
    UserMailer.individual_message(individual_message.id).deliver_later
    individual_message.update_attribute(:delivered_at, Time.now)
  end
end
