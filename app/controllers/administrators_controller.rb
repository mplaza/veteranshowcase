class AdministratorsController < ApplicationController
	def settings
		@admin = Admin.first
		@keywords = Admin.all[0].keywords.split(" OR ")

	end

end
