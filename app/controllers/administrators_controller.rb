class AdministratorsController < ApplicationController

before_action :authenticate_user, :only => [:index, :settings]
	
	def index

	end

respond_to :json, :html

	def settings
		@admin = Admin.first
		# @keywords = Admin.all[0].keywords.split(" OR ")
		@keyword = Keyword.new
		@keywords = Keyword.all
		# @admin.authors ||= "fds OR asfd"
		@author = Author.new
		@authors = Author.all
		@filteredword = Filteredwords.new
		@filteredwords = Filteredwords.all
	end

	# def update
	# 	@keyword = Keyword.find(params[:id])
	# 	if @keyword.update(keyword_params)
	# 		redirect_to settings_path
	# 	else
	# 		render 'settings'
	# 	end
	# end

	def newkeyword
		@keyword = Keyword.new
	end

	def keywordcreate
		@keyword = Keyword.new(keyword_params)
		if @keyword.save 
			redirect_to settings_path
		else 
			render 'newkeyword'
		end

	end

	def keyworddestroy
		@keyword = Keyword.find(params[:id])
		@keyword.destroy
		redirect_to settings_path
	end

	def newauthor
		@author = Author.new
	end

	def authorcreate
		@author = Author.new(author_params)
		if @author.save 
			redirect_to settings_path
		else 
			render 'newauthor'
		end

	end

	def authordestroy
		@author = Author.find(params[:id])
		@author.destroy
		redirect_to settings_path
	end

	def newfilteredword
		@filteredword = Filteredwords.new
	end

	def filteredwordcreate
		@filteredword = Filteredwords.new(filteredword_params)
		if @filteredword.save 
			redirect_to settings_path
		else 
			render 'newfilteredword'
		end

	end

	def returnfilteredwords
		@filteredwords = Filteredwords.all
		respond_with @filteredwords
	end
	def filteredworddestroy
		@filteredword = Filteredwords.find(params[:id])
		@filteredword.destroy
		redirect_to settings_path
	end

	def authenticate_user
    	if !current_admin
      		flash[:danger] = "Sorry buddy, you don't have access."
      		redirect_to posts_path
    	end
	end


	def keyword_params
		params.require(:keyword).permit(:searchterm, :admin_id)
	end

	def author_params
		params.require(:author).permit(:searchauthor, :admin_id)
	end

	def filteredword_params
		params.require(:filteredwords).permit(:negativesearch, :admin_id)
	end
end