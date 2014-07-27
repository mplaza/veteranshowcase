class Post < ActiveRecord::Base

	def self.party(keywords, authors)
		keywords = "veteran OR cat OR poodle"
		keywords = keywords.split(" OR ")
		puts keywords

		@results = []

		keywords.each do |k|
			feedzilla(k)
		end 
		
		@results = @results.flatten
		@results
	end


	def self.feedzilla(keywords)
		keywords ||= "veteran"

		auth = { query: { q: keywords }} 
		search_url = "http://api.feedzilla.com/v1/articles/search.json"
		
		response = HTTParty.get search_url, auth
		
		@results << response.parsed_response["articles"]
	end


	def huffington_post(authors)
	end


end
