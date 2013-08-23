class AddApprovedToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :approved, :boolean, :default => true
  end
end
