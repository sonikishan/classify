class CreateDefaultValues < ActiveRecord::Migration
  def change
    create_table :default_values do |t|
      t.integer :characteristic_id
      t.string :default_value

      t.timestamps
    end
  end
end
