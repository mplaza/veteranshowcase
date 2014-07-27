class UserpostsController < ApplicationController
	respond_to :json, :html
	
	def index
		@results = Post.find_by_sql('SELECT * FROM posts WHERE approved=true ORDER BY created_at DESC LIMIT 40')
		respond_with @results
	end
end
