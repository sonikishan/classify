class SessionsController < Devise::SessionsController

	def create
		if !current_user.blank?
			@blocked_ip_user = BlockedIp.find_by_user_id(current_user.id)
			if @blocked_ip_user.present?
				reset_session
				redirect_to root_path, :notice => "Your account has been blocked."
			else
				self.resource = warden.authenticate!(auth_options)
			    set_flash_message(:notice, :signed_in) if is_navigational_format?
			    sign_in(resource_name, resource)
			    respond_with resource, :location => after_sign_in_path_for(resource)
			end
		else
			redirect_to root_path, :notice => "Please check password and email address."
		end
  	end
end
