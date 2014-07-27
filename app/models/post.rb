require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'date'

class Post < ActiveRecord::Base

	def self.party(keywords, authors)
		keywords = keywords.split(" OR ")
		authors = authors.split(" OR ")
	
		@results = []

		keywords.each do |k|
			feedzilla(k)
		end 

		
		
		huffington_post
		
		
		@results = @results.flatten

		p "feedzilla"
		p @results

		@results
	end


	def self.feedzilla(keywords)
		keywords ||= "veteran"

		auth = { query: { q: keywords }} 
		search_url = "http://api.feedzilla.com/v1/articles/search.json"
		
		response = HTTParty.get search_url, auth
		
		response.parsed_response["articles"].each do |a|
			article = { "title" => a["title"], "author" => a["author"], "publication" => a["source"], "url" => a["url"], "publish_date" => DateTime.parse(a["publish_date"]) }
			@results << article
		end

		# @results << response.parsed_response["articles"]
	end


	def self.huffington_post
		url = "http://www.huffingtonpost.com/author/index.php?author=chris-marvin"
		doc = Nokogiri::HTML(open(url))

		doc.css("entry").each do |item|
			article = { "title" => item.at_css("title").text, "author" => item.at_css("author").at_css("name").text, "publication" => "Huffington Post", "url" => item.at_css("link")["href"], "publish_date" => DateTime.parse(item.at_css("published").text) }
			@results << article
		end

	end


end
