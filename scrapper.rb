require 'open-uri'
require 'nokogiri'

def scrap(keyword)
  # 1. We get the HTML page content thanks to open-uri
  html_content = open("https://www.etsy.com/search?q=#{keyword}").read
  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML(html_content)

  ideas = []

  # 3. We search for the correct elements containing the items' title in our HTML doc
  doc.search('.v2-listing-card .v2-listing-card__info').first(5).each do |element|
    # 4. For each item found, we extract its title and print it
    name = element.search('h3').text.strip
    price = element.search('.currency-value').text.strip.to_i

    new_gift_idea = {
      name: name,
      price: price,
      bought: false
    }

    ideas << new_gift_idea
  end

  return ideas

end
