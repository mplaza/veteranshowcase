class Apiarticle < ActiveRecord::Base

		def self.party(keyword)

		keyword ||= "veteran"

		auth = { query: { q: keyword }} 
		search_url = "http://api.feedzilla.com/v1/articles/search.json"
		
		response = HTTParty.get('http://api.feedzilla.com/v1/articles/search.json?=veteran')

		response.parsed_response["articles"]


		
	end



end
