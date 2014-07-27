class PostsController < ApplicationController

def index
	@admin = Admin.first
	@results = Post.party(@admin.keywords, @admin.authors)
end

def main

end



end
