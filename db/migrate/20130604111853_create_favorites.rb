class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user
      t.references :advertisement

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :advertisement_id
  end
end
