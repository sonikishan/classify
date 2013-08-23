class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :advertisement_id
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
