class AddPulldownToAbuseReport < ActiveRecord::Migration
  def change
    add_column :abuse_reports, :pulldown, :string
  end
end
