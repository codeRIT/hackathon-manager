class AddIsHomeToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :is_home, :boolean, default: false
  end
end
