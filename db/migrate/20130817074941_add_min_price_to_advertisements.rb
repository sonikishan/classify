class AddMinPriceToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :min_price, :float
  end
end
