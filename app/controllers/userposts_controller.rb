class UserpostsController < ApplicationController
	respond_to :json, :html
	
	def index
		@results = Post.where(approved: true)
		respond_with @results
	end
end
