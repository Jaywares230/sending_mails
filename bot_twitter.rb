require 'Twitter'
require 'json'


#je créais un client
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "2cGxMYI6uglBlFjhVoK30YsKB"
  config.consumer_secret     = "1VpKve1BcrFBze6uG26E7blL3wdFGakNnVG4MPB5okzmQFl2Vf"
  config.access_token        = "986188838858117120-6J9a0XK3bS7TSnoHs1cUEDYvXQSNJpU"
  config.access_token_secret = "Xj2XLQmlKxsYHRSELzVVDYmWt0ckoMIlaLJ3BURaAnvbu"
end



def push_handle

	handle_twitter.each do |i|
		json_to_ruby[i]['handle'] = '@'+handle_twitter
	end

end

#methode qui follow a partir du resultat ci-desus
def follow_user
	search_twitter.each do |i|
		client.follow(i)
		j +=0
	end
end