require 'httparty'
require 'json'

module Roadmap
	def get_roadmap(id)
		response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{id}", headers: { "authorization" => @user_auth_token })
		@my_roadmap = JSON.parse(response.body)
	end

	def get_checkpoint(id)
		response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{id}", headers: { "authorization" => @user_auth_token })
		@my_checkpoint = JSON.parse(response.body)
	end
end
