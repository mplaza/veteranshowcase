class PostsController < ApplicationController

def index
	@keywords = Keyword.all
	@authors = Author.all
	@results = Post.party(@keywords, @authors)
end

def main

end



end
