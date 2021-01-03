class ConvertAgreementsToText < ActiveRecord::Migration[5.2]
  def self.up
    change_column :agreements, :agreement_url, :text
    rename_column :agreements, :agreement_url, :agreement
  end

  def self.down
    rename_column :agreements, :agreement, :agreement_url
    change_column :agreements, :agreement_url, :sring
  end
end
