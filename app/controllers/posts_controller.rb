class PostsController < ApplicationController

def index

	@results = Post.party(params[:keywords], params[:authors])
end

def main

end



end
