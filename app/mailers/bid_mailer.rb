class BidMailer < ActionMailer::Base
  default from: "from@example.com"

  def bid_confirmation_email(advertise_owner, price, token)
  	@user = advertise_owner
    @bid_price = price
    @confirm_token = token
    # @url  = "http://122.170.114.91:3000"
    @url  = "http://weloco.herokuapp.com/"
    mail(:to => @user.email, :subject => "Bid Confirmation")
  end
  
  def bid_accepted_email(user, advertise)
  	@ad = advertise
    @user = user
    # @url  = "http://122.170.114.91:3000"
    @url  = "http://weloco.herokuapp.com/"
    mail(:to => @user.email, :subject => "Bid Accepted")
  end

  def contact_advertiser_email(message, email, phone)
  end
end
