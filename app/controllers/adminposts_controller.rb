class AdminpostsController < ApplicationController
	respond_to :json, :html

	def index
		@keywords = Keyword.all
		@authors = Author.all
		@results = Post.party(@keywords, @authors).sort_by {|result| result["publish_date"]}.reverse
		respond_with @results
	end

 	def create
    @post = Post.new(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to admin_path }
        format.json { render json: @post, status: :created }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def post_params
  	params.require(:adminpost).permit(:title, :publication, :author, :publish_date, :favorite, :url, :image, :approved, :saved)
  end

end
