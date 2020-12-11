class CreateAgreementsQuestionnairesJoin < ActiveRecord::Migration[5.2]
  def change
    create_table :agreements_questionnaires, id: false do |t|
      t.integer :agreement_id
      t.integer :questionnaire_id
    end
    add_index :agreements_questionnaires, ["agreement_id", "questionnaire_id"], name: "index_agreements_questionnaires"
  end
end
