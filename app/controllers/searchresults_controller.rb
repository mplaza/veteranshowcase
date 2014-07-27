class SearchresultsController < ApplicationController

def index
	@results = Searchresult.party(params[:keywords], params[:authors])
end



end
