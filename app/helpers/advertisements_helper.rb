module AdvertisementsHelper
	def get_username(user_id)
      @user = User.find(user_id)
      return @user.name
    end
end
