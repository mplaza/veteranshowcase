class Searchresult < ActiveRecord::Base

	def self.party(keywords, authors)

		feedzilla(keywords)

		
	end


	def feedzilla(keywords)
		keyword ||= "veteran"

		auth = { query: { q: keyword }} 
		search_url = "http://api.feedzilla.com/v1/articles/search.json"
		
		response = HTTParty.get search_url, auth
		response.parsed_response["articles"]
	end


	def huffington_post(authors)
	end


end
