class PostsController < ApplicationController

def index
	@keywords = Keyword.all
	@authors = Author.all
	@results = Post.party(@keywords, @admins).sort_by {|result| result["publish_date"]}.reverse
end

def main

end



end
