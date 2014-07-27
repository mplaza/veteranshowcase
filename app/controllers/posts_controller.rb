class PostsController < ApplicationController

def index
	@results = Searchresult.party(params[:keywords], params[:authors])
end

def main

end



end
