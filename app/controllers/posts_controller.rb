class PostsController < ApplicationController

def index
	@keywords = Keyword.all
	@authors = Author.all
	@results = Post.party(@admin.keywords, @admin.authors)
end

def main

end



end
