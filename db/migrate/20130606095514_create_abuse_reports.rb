class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.text :message
      t.references :user
      t.references :advertisement

      t.timestamps
    end
    add_index :abuse_reports, :user_id
    add_index :abuse_reports, :advertisement_id
  end
end
