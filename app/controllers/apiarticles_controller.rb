class ApiarticlesController < ApplicationController

def index
	@articles = Apiarticle.party(params[:keyword])
end



end
