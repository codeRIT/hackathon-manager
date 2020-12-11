class RemoveOldAgreementDataFromQuestionnaire < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :questionnaires, :agreement_accepted
    remove_column :questionnaires, :code_of_conduct_accepted
    remove_column :questionnaires, :data_sharing_accepted
  end

  def self.down
    add_column :questionnaires, :agreement_accepted, :bool, default: false
    add_column :questionnaires, :code_of_conduct_accepted, :bool, default: false
    add_column :questionnaires, :data_sharing_accepted, :bool, default: false
  end
end
