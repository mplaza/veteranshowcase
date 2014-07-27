class PostsController < ApplicationController
	respond_to :json, :html


def index
	@keywords = Keyword.all
	@authors = Author.all
	@results = Post.all
end

def main

end

def authenticate_user
    if !current_admin
      flash[:danger] = "Sorry buddy, you don't have access."
      redirect_to root_path
    end
end


end
