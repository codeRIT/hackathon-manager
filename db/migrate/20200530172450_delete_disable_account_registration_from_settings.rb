class DeleteDisableAccountRegistrationFromSettings < ActiveRecord::Migration[5.2]
  def self.up
    return unless HackathonConfig.find_by(var: 'disable_account_registration').present?
    HackathonConfig.find_by(var: 'disable_account_registration').destroy
  end

  def self.down
    HackathonConfig.create(var: 'disable_account_registration', value: false)
  end
end
