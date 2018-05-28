class StocksController < ApplicationController
  def index
    require 'nokogiri'
    require 'open-uri'
    # Fetch and parse HTML document
    doc = Nokogiri::HTML(open('http://www.nokogiri.org/tutorials/installing_nokogiri.html'))
    puts "### Search for nodes by css"
    doc.css('.title').each do |link|
      @test = link.content
    end
  end
end
