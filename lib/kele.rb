require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
	include HTTParty
	include Roadmap

	def initialize(username, password)
		@bloc_base_api_url = "https://www.bloc.io/api/v1/sessions"

		response = self.class.post(@bloc_base_api_url, body: {email: username, password: password})

		@user_auth_token = response["auth_token"]
		@user_email = username

		puts 'Invalid credentials' if @user_auth_token.nil?
	end

	def get_me
		response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @user_auth_token })
		@my_data = JSON.parse(response.body)
	end

	def get_mentor_availability
		response = self.class.get("https://www.bloc.io/api/v1/mentors/2299934/student_availability", headers: { "authorization" => @user_auth_token })
		@my_mentor_avilability = JSON.parse(response.body)
	end

	def get_messages(page = 0)
		if page > 0
			response = self.class.get("https://www.bloc.io/api/v1/message_threads?page=#{page}", headers: { "authorization" => @user_auth_token })
		else
			response = self.class.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => @user_auth_token })
		end

		@my_message_threads = JSON.parse(response.body)['items']
	end

	def create_message(recipient_id, message_thread_token, subject, body)
		response = self.class.post("https://www.bloc.io/api/v1/messages",
			body: {
				sender: @user_email,
				recipient_id: recipient_id,
				token: message_thread_token,
				subject: subject,
				"stripped-text": body
				})

		response ? "Message sent" : "Something went wrong"
	end
end
