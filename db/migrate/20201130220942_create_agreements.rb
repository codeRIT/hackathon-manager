class CreateAgreements < ActiveRecord::Migration[5.2]
  def change
    create_table :agreements do |t|
      t.string :name
      t.string :agreement
      t.timestamps
    end
  end
end
