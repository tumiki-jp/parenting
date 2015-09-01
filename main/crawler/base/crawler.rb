# _*_ coding: utf-8 _*_
require './main/config/capybara-config.rb'

class Crawler
  #
  include Capybara::DSL

  # サイトトップページのURL
  attr_reader :site_url

  def initialize()
    puts "Crawler initialize()"
  end

  def run()
    # first Step Show web site
    puts "#{Time.new()} : VISIT #{@site_url}"
    visit(@site_url)

    # crawl
    puts "#{Time.new()} : START CRAWLER"
    crawl()
    puts "#{Time.new()} : END CRAWLER"

  end

  def crawl()
    raise "not implement exception. please override crawl()"
  end
end
