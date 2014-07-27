class AdminpostsController < ApplicationController
	respond_to :json, :html

	def index
		@keywords = Keyword.all
		@authors = Author.all
		@results = Post.party(@keywords, @authors).sort_by {|result| result["publish_date"]}.reverse
		respond_with @results
	end
end
