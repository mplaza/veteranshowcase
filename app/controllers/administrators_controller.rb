class AdministratorsController < ApplicationController
	def settings
		@admin = Admin.first
		# @keywords = Admin.all[0].keywords.split(" OR ")
		@keywords = @admin.keywords.split(" OR ")
		# @admin.authors ||= "fds OR asfd"
		@authors = @admin.authors.split(" OR ")
	end

	def update
		@admin = Admin.first
		if @admin.update(admin_params)
			redirect_to root_path
		else
			render 'settings'
		end
	end


	def admin_params
		params.require(:admin).permit(:keywords, :authors, :filteredwords)
	end
end
