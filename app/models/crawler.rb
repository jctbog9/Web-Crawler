require 'nokogiri'
require 'open-uri'

class Crawler
  attr_reader :page
  attr_accessor :data, :id, :javascript, :non_specific

  def initialize
    @javascript = 0
    @non_specific = 0
    @data = []
  end

  def trending
    page = Nokogiri::HTML(open('https://github.com/trending?since=weekly'))
    repositories = page.css(".repo-list li")
    repositories.each do |repository|
      puts repository.css("h3")[0].text.strip
      puts "==========================="
      if repository.css("p").text != ""
        puts repository.css("p")[0].text.strip
      end
      puts ""
      if repository.at("[@itemprop = 'programmingLanguage']")
        puts "Written primarily in #{repository.at("[@itemprop = 'programmingLanguage']").children.text.delete("\n").split[0]}"
        if repository.at("[@itemprop = 'programmingLanguage']").children.text.delete("\n").split[0] == "JavaScript"
          @javascript += 1
        end
        puts ""
      else
        @non_specific += 1
      end
      contributors = []
      repository.css(".d-inline-block.mr-3").children.css("a").each do |contributor|
        if contributor.children[-1].attributes["alt"].nil? == false
          contributors << contributor.children[-1].attributes["alt"].value.delete("@")
        end
      end
      puts "Primary Contributors: #{contributors.join(', ')}"
      puts ""
      puts "---------------------------"
    end
  end

  def javascript
    @javascript = 0
    @data.each do |repository|
      if !repository[:language].nil?
        if repository[:language].downcase == "javascript"
          @javascript += 1
        end
      end
    end
    return @javascript
  end

  def no_language
    @non_specific = 0
    @data.each do |repository|
      if repository[:language].nil?
        @non_specific += 1
        puts repository[:repo]
      end
    end
    return @non_specific
  end

  def create_data
    @data = []
    page = Nokogiri::HTML(open('https://github.com/trending?since=weekly'))
    repositories = page.css(".repo-list li")
    repositories.each do |repository|
      repo_payload = {}
      repo_payload.merge!(repo: repository.css("h3")[0].text.strip)
      if repository.css("p").text != ""
        repo_payload.merge!(description: repository.css("p")[0].text.strip)
      else
        repo_payload.merge!(description: nil)
      end

      if repository.at("[@itemprop = 'programmingLanguage']")
        repo_payload.merge!(language: repository.at("[@itemprop = 'programmingLanguage']").children.text.delete("\n").split[0])
      else
        repo_payload.merge!(language: nil)
      end

      contributors = []
      repository.css(".d-inline-block.mr-3").children.css("a").each do |contributor|
        if contributor.children[-1].attributes["alt"].nil? == false
          contributors << contributor.children[-1].attributes["alt"].value.delete("@")
        end
      end

      repo_payload.merge!(contributors: contributors)
      @data << repo_payload
    end
    return @data
  end

  def clear_data
    @data = []
  end
end
