class AddNameAndEmailAndZipcodeAndPhonenumberToAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :name, :string
    add_column :advertisements, :email, :string
    add_column :advertisements, :zipcode, :integer
    add_column :advertisements, :phonenumber, :integer
  end
end
