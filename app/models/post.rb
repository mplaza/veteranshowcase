require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'date'

class Post < ActiveRecord::Base

	def self.party(keywords, authors)
		keywords = keywords
		authors = authors
	
		@results = []

		keywords.each do |k|
			feedzilla(k.searchterm)
			# homes100k(k.searchterm)
		end 
		
		authors.each do |a|
			huffington_post(a.searchauthor)
		end

		# huffington_post

		bluestarfam()
		bobwoodruff()
		vetssyracuse()
			
		
		@results = @results.flatten
		@results
	end


	def self.feedzilla(keyword)
		auth = { query: { q: keyword }} 
		search_url = "http://api.feedzilla.com/v1/articles/search.json"
		
		response = HTTParty.get search_url, auth
		
		response.parsed_response["articles"].each do |a|
			article = { "title" => a["title"], "author" => a["author"], "publication" => a["source"], "url" => a["url"], "publish_date" => DateTime.parse(a["publish_date"]) }
			@results << article
		end
	end


	def self.huffington_post(author)

		author = author.split(" ").join("-")

		url = "http://www.huffingtonpost.com/author/index.php?author=" + author
		doc = Nokogiri::HTML(open(url))

		doc.css("entry").each do |item|
			article = { "title" => item.at_css("title").text, "author" => item.at_css("author").at_css("name").text, "publication" => "Huffington Post", "url" => item.at_css("link")["href"], "publish_date" => DateTime.parse(item.at_css("published").text) }
			@results << article
		end
	end

	# def self.homes100k(keyword)
 #    	url = "http://100khomes.org/search/node/" + keyword
 #    	doc = Nokogiri::HTML(open(url))
    	
 #    	doc.css("title").each do |item|
 #    		article = { "title" => item.at_css(".title").text, "author" => "", "publication" => "100k Homes Blog", "url" => "", "image_url" => "",  "publish_date" => DateTime.parse("")}
 #    	@results << article
 #    end
 #  end

   def self.bluestarfam
    url = "http://bluestarfam.org/blog"
    doc = Nokogiri::HTML(open(url))

    doc.css(".content-item").each do |item|

    	article = { "title" => item.at_css("h2").text, "publication" => "Blue Star", "url" => url+ item.at_css("a")["href"] }

      @results << article
    end
  end

  	def self.bobwoodruff

		url = "http://bobwoodrufffoundation.org/bwf-news/"
		doc = Nokogiri::HTML(open(url))

		doc.css(".holder").each do |item|
			article = { "title" => item.at_css("a").text, "publication" => "Bob Woodruff Foundation", "url" => item.at_css("a")["href"], "publish_date" => DateTime.parse(item.at_css(".meta").text) }
			@results << article
		end

	end


	def self.vetssyracuse
    	url = "http://vets.syr.edu/feed/"
   		doc = Nokogiri::XML(open(url))

    doc.css("item").each do |item|

    	article = { "title" => item.at_css("title").text, "author" => item.at_xpath("dc:creator").text, "publication" => "Vets Syracuse", "url" => item.at_xpath("link").text, "publish_date" => DateTime.parse(item.at_xpath("pubDate").text)}

    	@results << article
    end
  end


end
