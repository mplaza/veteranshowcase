class UserpostsController < ApplicationController
	respond_to :json, :html
	
	def index
		@results = Post.where(approved: true)
		respond_with @results
	end

	def savedpostindex
		@results = Post.where(saved: true)
		respond_with @results
	end

	def update
		@post = Post.find(params[:id])

	    if @post.update(post_params)
	      respond_to do |format|
	        format.html { redirect_to admin_userview_path }
	        format.json { render nothing: true, status: :no_content }
	      end
	    else
	      respond_to do |format|
	        format.html { render 'edit' }
	        format.json { render json: @post.errors, status: :unprocessable_entity }
	      end
	    end
  	end

  	def destroy
  		@post = Post.find(params[:id])
    	@post.destroy
    	respond_to do |format|
      		format.html { redirect_to admin_userview_path }
      		format.json { render json: { head: :ok } }
    	end
  	end

  	def post_params
  		params.require(:userpost).permit(:title, :publication, :author, :publish_date, :favorite, :url, :image, :approved, :saved)
  	end

end
