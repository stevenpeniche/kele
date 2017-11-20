require 'httparty'
require 'json'

class Kele
	include HTTParty

	def initialize(username, password)
		@bloc_base_api_url = "https://www.bloc.io/api/v1/sessions"

		response = self.class.post(@bloc_base_api_url, body: {email: username, password: password})

		@user_auth_token = response["auth_token"]

		puts 'Invalid credentials' if @user_auth_token.nil?
	end

	def get_me
		response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @user_auth_token })
		@my_data = JSON.parse(response.body)
	end
end
