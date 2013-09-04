class CharacteristicsController < ApplicationController
  # GET /characteristics
  # GET /characteristics.json
  before_filter :signed_in_user
  
  def index
    @characteristics = Characteristic.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.js
      # format.json { render json: @characteristics }
    end
  end

  def getchars
    render :layout => false
  end
  
  # GET /characteristics/1
  # GET /characteristics/1.json
  def show
    @characteristic = Characteristic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @characteristic }
    end
  end

  # GET /characteristics/new
  # GET /characteristics/new.json
  def new
    @characteristic = Characteristic.new
    
    @flag = false
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @characteristic }
    end
  end

  # GET /characteristics/1/edit
  def edit
    @characteristic = Characteristic.find(params[:id])
    
    @flag = false
  end

  # POST /characteristics
  # POST /characteristics.json
  def create
    @characteristic = Characteristic.new(params[:characteristic])

    respond_to do |format|
      if @characteristic.save
        format.html { redirect_to @characteristic, notice: 'Characteristic was successfully created.' }
        format.json { render json: @characteristic, status: :created, location: @characteristic }
      else
        format.html { render action: "new" }
        format.json { render json: @characteristic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /characteristics/1
  # PUT /characteristics/1.json
  def update
    @characteristic = Characteristic.find(params[:id])

    respond_to do |format|
      if @characteristic.update_attributes(params[:characteristic])
        format.html { redirect_to @characteristic, notice: 'Characteristic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @characteristic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characteristics/1
  # DELETE /characteristics/1.json
  def destroy
    @characteristic = Characteristic.find(params[:id])
    @characteristic.destroy

    respond_to do |format|
      format.html { redirect_to characteristics_url }
      format.json { head :no_content }
    end
  end
  def select_input_kind
    @flag = true
    @status = params[:status]
    if @status == "check"
      @status = "check"
    elsif @status == "uncheck"
      @status = "uncheck"
    end
  end
  protected

  def signed_in_user
    if user_signed_in?
      redirect_to root_path unless current_user.admin?
    else
      redirect_to root_path
    end
  end
end
