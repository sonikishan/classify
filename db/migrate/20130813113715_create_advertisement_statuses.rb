class CreateAdvertisementStatuses < ActiveRecord::Migration
  
    def change
    create_table :advertisement_statuses do |t|
   
      t.string :status
      t.timestamps
    end
    AdvertisementStatus.create :status => "Active"
    AdvertisementStatus.create :status => "Blocked"
    AdvertisementStatus.create :status => "Sold"
    AdvertisementStatus.create :status => "Reserved"
  end
end
