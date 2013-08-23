class WelocoPagesController < ApplicationController

  before_filter :authenticate_user!, only: [:profile, :myads, :myfavs]

  def home
    @advertisements = []
     @abuse_Ad = AbuseReport.cheaper_than(ABUSE_REPORT_COUNT)
     if !@abuse_Ad.blank?
      @abuse_Ad.each do |abuse_ad|
        @advertisements << Advertisement.where("id not in (?)",abuse_ad.advertisement_id).order('created_at DESC')
        @advertisements = @advertisements.flatten!

      end
    else
      @advertisements << Advertisement.all
      @advertisements = @advertisements.flatten!
      
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def profile  	
    @status = AdvertisementStatus.all
  end
  def myprofile
  end
  def myads
     @status = AdvertisementStatus.all
  end
 def myads_listing
     @abuse_Ad = AbuseReport.cheaper_than(ABUSE_REPORT_COUNT) 
     @abuse_Ad.each do |abuse_ad| 
      if !params[:keyword].nil? || !params[:category_id].nil? || !params[:advertisement_status_id].nil? 
        @myads = Advertisement.where('title LIKE ? OR category_id = ? AND advertisement_status_id = ? AND user_id = ? AND id not in (?)', params[:keyword],params[:category_id],params[:advertisement_status_id],current_user.id,abuse_ad.advertisement_id)
      else 
        @myads = Advertisement.where('user_id = ? AND id not in (?)',current_user.id,abuse_ad.advertisement_id).order("id desc") 
      end 
    end
  end

  def myfavs
  end  

end
