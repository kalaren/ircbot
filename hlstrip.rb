require 'nokogiri'
require 'open-uri'

data = Nokogiri::HTML(open("http://thestar.com"))

puts data.at_css(".headline").text.strip