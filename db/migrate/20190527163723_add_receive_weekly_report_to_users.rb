class AddReceiveWeeklyReportToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :receive_weekly_report, :boolean, default: false
  end
end
