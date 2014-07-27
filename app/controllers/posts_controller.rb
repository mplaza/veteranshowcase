class PostsController < ApplicationController
	respond_to :json, :html


before_action :authenticate_user, :only => [:index]


def index
	@keywords = Keyword.all
	@authors = Author.all
	@results = Post.party(@keywords, @authors).sort_by {|result| result["publish_date"]}.reverse
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
