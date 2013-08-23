class AbuseReportMailer < ActionMailer::Base
  default from: "suryakant.maurya1810@gmail.com"

  def abuse_report_email(user, ad)
    @user = user
    @ad = ad
    @url  = "http://weloco.herokuapp.com/sign_up"
    mail(:to => @user.email, :subject => "Abuse Report")
  end

  def abuse_report_owner_email(ad)
  	@ad = ad
  	@user = User.find(@ad.user_id)
  	@url  = "http://weloco.herokuapp.com/sign_up"
    mail(:to => @user.email, :subject => "Blocked Advertisement")
  end
  
  def send_message(message,advertisement,admin,user,phone)
    @message = message
    @advertisement = Advertisement.find(advertisement)
    @admin = admin
    @user = user
    @phone = phone
    mail(:from => @user,:to => @admin.email, :subject => "Inquiry")
  end
end
