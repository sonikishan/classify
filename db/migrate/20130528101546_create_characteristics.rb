class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.string :name
      t.string :input_kind
      t.text :default_values
      t.references :category

      t.timestamps
    end
    add_index :characteristics, :category_id
  end
end
