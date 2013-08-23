class BidsController < ApplicationController
  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bids }
    end
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
    @bid = Bid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bid }
    end
  end

  # GET /bids/new
  # GET /bids/new.json
  def new
    # @bid = Bid.new
     token = params[:confirmation_token] 
     bid = Bid.where(:confirmation_token => token) 
     if bid[0].id 
        @bid = Bid.find(bid[0].id) 
        handle_redirection(@bid) 
     end 

    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @bid }
    # end
  end

  def handle_redirection(bid)
    bid.update_attributes(:confirmed_at => Time.now, :confirmation_token => '') 
    @advertise = Advertisement.find(bid.advertisement_id) 
    @advertise.update_attributes(:price => bid.price)
    @user = User.find(bid.user_id)
    BidMailer.bid_accepted_email(@user, @advertise).deliver 
    redirect_to @advertise, :notice => "Your have accepted bid for this advertisement." 
  end

  # GET /bids/1/edit
  def edit
    @bid = Bid.find(params[:id])
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(params[:bid])

    respond_to do |format|
      if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render json: @bid, status: :created, location: @bid }
      else
        format.html { render action: "new" }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bids/1
  # PUT /bids/1.json
  def update
    @bid = Bid.find(params[:id])

    respond_to do |format|
      if @bid.update_attributes(params[:bid])
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy

    respond_to do |format|
      format.html { redirect_to bids_url }
      format.json { head :no_content }
    end
  end

  

end
