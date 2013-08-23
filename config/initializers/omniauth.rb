Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, "484149525001132", "a74571999f03fbaac4d497066df0f33f", {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
 
  # If you want to also configure for additional login services, they would be configured here.
end