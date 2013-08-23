class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :salutation, :string
    add_column :users, :address, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :phone, :string
    add_column :users, :url, :string
    add_column :users, :longitude, :integer
    add_column :users, :latitude, :integer
  end
end
