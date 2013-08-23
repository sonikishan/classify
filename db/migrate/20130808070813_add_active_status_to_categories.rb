class AddActiveStatusToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :active_status, :boolean, :default => true
  end
end
