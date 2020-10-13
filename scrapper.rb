require 'open-uri'
require 'nokogiri'

def scrap(keyword)


end

# # 1. We get the HTML page content thanks to open-uri
# html_content = open("https://www.etsy.com/search?q=socks").read
# # 2. We build a Nokogiri document from this file
# doc = Nokogiri::HTML(html_content)

# # 3. We search for the correct elements containing the items' title in our HTML doc
# doc.search('.v2-listing-card .v2-listing-card__info .text-body').each do |element|
#   # 4. For each item found, we extract its title and print it
#   puts element.text.strip
# end




# PENSEZ BIEN A FAIRE LE CURL

filepath = "/path/to/the/HTML/file.html"
# 1. We get the HTML page content
html_content = File.open(filepath)
# 2. We build a Nokogiri document from this file
doc = Nokogiri::HTML(html_content)

# 3. We search for the correct elements containing the items' title in our HTML doc
doc.search('.v2-listing-card .v2-listing-card__info .text-body').first(5).each do |element|
  # 4. For each item found, we extract its title and print it
  puts element.text.strip
end
