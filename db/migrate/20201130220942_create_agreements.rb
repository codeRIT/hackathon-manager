class CreateAgreements < ActiveRecord::Migration[5.2]
  def change
    create_table :agreements do |t|
      t.string :name

      t.timestamps
    end
    add_column :agreements, :agreement_url, :text
  end
end
