class AddMaxPriceToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :max_price, :float
  end
end
