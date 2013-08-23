class AddMultiselectToCharacteristics < ActiveRecord::Migration
  def change
    add_column :characteristics, :multiselect, :boolean, :default => false
  end
end
