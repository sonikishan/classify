class AdvertisementsController < ApplicationController
  
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :abuse_report]
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :abuse_report] do 
    redirect_to root_path unless current_user.super_user? || current_user.admin? 
  end

  # GET /advertisements
  # GET /advertisements.json
  def index
      @advertisement = Advertisement.all
      @advertisements = Advertisement.paginate(:page => params[:page], :per_page => 5)
      @advertisement_abuse =AbuseReport.paginate(:page => params[:page], :per_page => 3).where("advertisement_id in (?)",@advertisement)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advertisements }
    end
  end
  def abuse_ads_listing_admin
    @advertisements = Advertisement.all
    @advertisement_abuse =AbuseReport.paginate(:page => params[:page], :per_page => 2).where("advertisement_id in (?)",@advertisements)

    respond_to do |format|
      format.js
    end
  end

  # GET /advertisements/1
  # GET /advertisements/1.json
  def show
    @advertisement = Advertisement.find(params[:id])
    @contact = Contact.new
    if @advertisement.view_count.nil?
      @advertisement.view_count = ViewCount.new(:amount => 1)
      else
        count = @advertisement.view_count.amount
        @advertisement.view_count.update_attributes(:amount => count + 1)
    end

    if @advertisement.advertisement_status_id == 0
      redirect_to root_path, notice: "Sorry, the advertisement you requested has been blocked by admin due to abuse reports"
      else
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @advertisement }
        end
    end
  end

  # GET /advertisements/new
  # GET /advertisements/new.json
  def new
    @advertisement = Advertisement.new
    @characteristics_status = "0"
    @category = Category.roots.where(:active_status => true)

    #@child_category= Category.roots
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertisement }
    end
  end

  # GET /advertisements/1/edit
  def edit
    @advertisement = Advertisement.find(params[:id])
    @characteristics_status = "0"
    @category = Category.roots.where(:active_status => true)
    #authorize! :edit, @advertisement
  end

  # POST /advertisements
  # POST /advertisements.json
  def create
    
    @advertisement = Advertisement.new(params[:advertisement])
    if user_signed_in?
      @advertisement.user_id = current_user.id
      @advertisement.advertisement_status_id = 1
    end  
    @category = Category.roots.where(:active_status => true)

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully created.' }
        format.json { render json: @advertisement, status: :created, location: @advertisement }
      else
        format.html { render action: "new" }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advertisements/1
  # PUT /advertisements/1.json
  def update
    @advertisement = Advertisement.find(params[:id])

    respond_to do |format|
      if @advertisement.update_attributes(params[:advertisement])
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisements/1
  # DELETE /advertisements/1.json
  def destroy
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy

    respond_to do |format|
      format.html { redirect_to advertisements_path ,:notice => "Advertisement was successfully deleted."}
      format.json { head :no_content }
    end
  end
  def first_phase
    @category = Category.find(params[:id])
    
      @child_category_ids = @category.child_ids
       @child_category = Category.where("id in (?) AND active_status = ?",@child_category_ids,true)
  
  end
  def second_phase
    @category = Category.find(params[:id])

    @child_category_ids = @category.child_ids
     @child_category = Category.where("id in (?) AND active_status = ?",@child_category_ids,true)
  end

  def characteristics_list
  @advertisement = Advertisement.new
    @category = Category.find(params[:id])
    if params[:status] == "child"
      @child_category_ids = @category.child_ids
      @child_category = Category.where("id in (?)",@child_category_ids)
      @characteristics_list = @child_category.first.characteristics
      @characteristics_status = "1"
 
    else
      @characteristics_list = @category.characteristics
      @characteristics_status = "1"
    
    end
    respond_to do |format|
      format.js
    end
  end

  def large_img
    @advertisementimage = AdvertisementImage.find(params[:id])
    @advertisement = Advertisement.find(@advertisementimage.advertisement.id)

    render :layout => false
  end
  def select_large_image
    @advertisementimage = AdvertisementImage.find(params[:id])
    render :layout => false
  end
  def bid
    @advertisement = Advertisement.find(params[:id])
    if !user_signed_in?
      redirect_to(@advertisement, notice: "Please sign in to bid") and return
    end
    
    if ((params[:price].to_i) <= @advertisement.price.to_i)
      redirect_to(@advertisement, notice: "Bid must be higher than the previous bid") and return
    end  

    # redirect_to @advertisement, notice:  "Please, sign in first" if !user_signed_in?
    # user = current_user
    if Bid.exists?(:advertisement_id => params[:id], :user_id => current_user.id)
      redirect_to @advertisement,  notice:  "You already have bid for this ad"
      else
        token = SecureRandom.hex(13)
        price = params[:price].to_i
        advertise_owner = User.find(@advertisement.user_id)
        current_user.bids << Bid.new(advertisement_id: @advertisement.id, price: price, confirmation_token: token)
        BidMailer.bid_confirmation_email(advertise_owner, price, token).deliver 
        redirect_to @advertisement, notice: "Thanks for bidding, Now wait untill advertise owner confirms."
    end
  end
  def abuse_ad_status
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.approved == true
      @advertisements = AbuseReport.find_by_advertisement_id(@advertisement)
      if !@advertisements.nil?
        @advertisements.destroy
      end
      @advertisement.update_attributes(:approved => false)
    else
      @advertisement.update_attributes(:approved => true)
    end
  end
  def abuse_report
    @advertisement = Advertisement.find(params[:id])
    if AbuseReport.exists?(:advertisement_id => params[:id], :user_id => current_user.id)
      redirect_to @advertisement, notice: "You already have abused this advertisement"
      else
        current_user.abuse_reports << AbuseReport.new(advertisement_id: @advertisement.id, message: params[:message], pulldown: params[:pulldown])
        AbuseReportMailer.abuse_report_email(current_user, @advertisement).deliver 
        @advertisement.update_attributes(:advertisement_status_id => 2) if @advertisement.abuse_reports.count == ABUSE_REPORT_COUNT
        AbuseReportMailer.abuse_report_owner_email(@advertisement).deliver if @advertisement.abuse_reports.count == ABUSE_REPORT_COUNT
        redirect_to @advertisement, notice: "You have abused this advertisement"
    end     
  end
  
  # Add and remove favorite Advertise
  # for current_user
  def favorite
    @advertisement = Advertisement.find(params[:id])
    type = params[:type]
    if type == "favorite" && !Favorite.exists?(:advertisement_id => @advertisement.id, :user_id => current_user.id)
      current_user.favorites << Favorite.new(:advertisement_id => @advertisement.id)
      redirect_to :back, notice: "You favorited #{@advertisement.title}"

    elsif type == "unfavorite"
      fav = get_favorite(@advertisement.id, current_user.id)
      Favorite.delete(fav)
      redirect_to :back, notice: "Unfavorited #{@advertisement.title}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'You alredy have this Advertisement in Favorite list'
    end
  end

  def get_favorite(aid, uid)
    @fav_is = Favorite.where(:advertisement_id => aid, :user_id => uid)
    for favs in @fav_is do
      fid = favs.id
    end
    return fid
  end

  def contact_advertiser
    @admin = User.where(:role => "super_admin")
    @contact = Contact.new(params[:contact])
    @contact.advertisement_id = params[:id]
    if @contact.save!
      @admin.each do |admin|
      AbuseReportMailer.send_message(@contact.message, @contact.advertisement_id,admin,@contact.email,@contact.phone).deliver 
      end
      redirect_to :back, :notice => "Successfully Message Send!"
    else
      redirect_to :back, :notice => "PLease send message again!"
    end
    #@advertisement = Advertisement.find(params[:id])
    #@user = User.find(@advertisement.user_id)
     #message = params[:client_message]
     #email = params[:client_email]
     #phone = params[:client_phone]
    #redirect_to :back, notice: "Message: #{message}, email: #{email}, phone: #{phone}"
    # redirect_to :back, notice: "This is contact advertiser method"
  end
end

