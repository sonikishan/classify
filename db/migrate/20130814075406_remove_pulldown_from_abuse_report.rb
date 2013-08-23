class RemovePulldownFromAbuseReport < ActiveRecord::Migration
  def up
    remove_column :abuse_reports, :pulldown
    add_column :abuse_reports, :pulldown, :integer
  end

  def down
  	remove_column :abuse_reports, :pulldown
    add_column :abuse_reports, :pulldown, :string

  end
end
