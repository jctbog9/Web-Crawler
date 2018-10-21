require 'nokogiri'
require 'open-uri'
require 'pry'

TRENDING_URL = 'https://github.com/trending?since=weekly'
page = Nokogiri::HTML(open(TRENDING_URL))

javascript = 0

repositories = page.css(".repo-list li")

repositories.each do |repository|
  puts repository.css("h3")[0].text.strip
  puts "==========================="
  puts repository.css("p")[0].text.strip
  puts
  puts "Written primarily in #{repository.css(".d-inline-block.mr-3")[0].children.text.delete("\n").split[0]}"
  puts
  contributors = []
  repository.css(".d-inline-block.mr-3").children.css("a").each do |contributor|
    if contributor.children[-1].attributes["alt"].nil? == false
      contributors << contributor.children[-1].attributes["alt"].value.delete("@")
    end
  end
  puts "Primary Contributors: #{contributors.join(", ")}"
  puts "---------------------------"
end
