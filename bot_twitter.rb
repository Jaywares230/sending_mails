require 'Twitter'
require 'json'


#je créais un client
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "YOURKEY"
  config.consumer_secret     = "YOURKEY"
  config.access_token        = "YOURKEY"
  config.access_token_secret = "YOURKEY"
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
