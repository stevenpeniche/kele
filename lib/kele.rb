require 'httparty'

class Kele
	include HTTParty

	def initialize(username, password)
		@bloc_base_api_url = "https://www.bloc.io/api/v1/sessions"

		response = self.class.post(@bloc_base_api_url, body: {email: username, password: password})

		@user_auth_token = response["auth_token"]

		puts 'Invalid credentials' if @user_auth_token.nil?
	end
end
