class UsersController < ApplicationController
  before_filter :authenticate_user!
   before_filter :authenticate_user! do 
    redirect_to root_path unless current_user.super_user? || current_user.admin?
  end



  def index
   @users = User.search(params[:search]).paginate(:page => params[:page],:per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
  end
  
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

 
  def edit
    @user = User.find(params[:id])
  end

  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save!
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path , notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  def block_status
  	@user = User.find(params[:id])
  	if @user.account_active == true
  	@user.update_attributes(:account_active => false)
  else
  	@user.update_attributes(:account_active => true)
  end	
  end
  def block_ip_status
    @user = User.find(params[:id])
    if @user.block_ip == true
       @blocked_ip_user = BlockedIp.find_by_user_id_and_ip_address(@user.id,@user.last_sign_in_ip)
       @blocked_ip_user.destroy
      @user.update_attributes(:block_ip => false)
    else
      @blocked_ip_user = BlockedIp.create(:user_id => @user.id,:ip_address => @user.last_sign_in_ip)
      @user.update_attributes(:block_ip => true)
    end 
  end
end
