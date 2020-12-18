class ConvertAgreementsToText < ActiveRecord::Migration[5.2]
  def change
    change_column :agreements, :agreement_url, :text
    rename_column :agreements, :agreement_url, :agreement
  end
end
