# _*_ coding: utf-8 _*_
require 'nokogiri'
require 'open-uri'
require 'uri'

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'


class YouTubeSite < MovieSite

  def initialize()
    puts "YouTubeSite#initialize"

    @base_url = "https://www.youtube.com/"
  end

  def run()

    # Step 1 Show web site
    visit(@base_url)

    # Step 2 Set parenting word to search box
    find(:xpath, '//*[@id="masthead-search-term"]').set("子育て 1歳")

    # Step 3 Click search button
    find(:xpath, '//*[@id="search-btn"]').click

    # # Step 4 Filter to Today
    # find(:xpath, '//*[@id="content"]/div/div/div/div[1]/div/div[2]/div[1]/div[1]/div/div[1]/button').click
    # find(:xpath, '//*[@id="filter-dropdown"]/div[1]/ul/li[2]/a').click

    # Step 5 Sort with upload date
    sleep 1
    find(:xpath, '//*[@id="content"]/div/div/div/div[1]/div/div[2]/div[1]/div[1]/div/div[1]/button').click
    sleep 1
    find(:xpath, '//*[@id="filter-dropdown"]/div[5]/ul/li[2]/a').click

    # Step 6 navigate to movie page
    # all(:xpath, '//*[contains(@id, "item-section-")]/li/div/div').each do |movie_element|
    #   sleep 1
    #   @url = movie_element.find(:xpath, 'div//h3[contains(@class, "yt-lockup-title ")]/a')[:href]
    #   puts "url => #{@url}"
    #   movie_element.find(:xpath, 'div//h3[contains(@class, "yt-lockup-title ")]/a').click
    # end

    sleep 1
    urls = []
    all(:xpath, '//*[contains(@id, "item-section-")]/li/div/div').each do |movie_element|
      urls << movie_element.find(:xpath, 'div//h3[contains(@class, "yt-lockup-title ")]/a')[:href]
    end
    puts urls

    count = 0
    urls.each do |url|

      # Step 7 Get metadata
      visit(url)
      #sleep 1
      count += 1
      puts count

      @url = url
      puts "url => #{@url}"

      @title = find(:xpath, '//*[@id="eow-title"]')[:title]
      puts "title => #{@title}"
      if @title.include?("猫") || @title.include?("犬")
        puts "Skip #{@url}"
        next
      end

      if has_selector?(:xpath, '//*[@id="eow-description"]')
        @description = find(:xpath, '//*[@id="eow-description"]').text
      else
        @description = "説明なし"
      end
      puts "description => #{@description}"
      if @description.include?("猫") || @description.include?("犬")
        puts "Skip #{@url}"
        next
      end

      @tags = []
      puts "tags => #{@tags}"

      @release_date = find(:xpath, '//*[@id="watch-uploader-info"]/strong').text
      puts "release_date => #{@release_date}"

      @view_count = find(:xpath, '//*[@id="watch7-views-info"]/div[1]').text
      puts "view_count => #{@view_count}"

      if has_selector?(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span')
        @like_count = find(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span').text
      else
        @like_count = "0"
      end
      puts "like_count => #{@like_count}"

      if has_selector?(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span')
        @dislike_count = find(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span').text
      else
        @dislike_count = "0"
      end
      puts "dislike_count => #{@dislike_count}"

      @comments = "" #find(:xpath, '').text
      puts "comments => #{@comments}"

      #@thumbnail = find(:xpath, 'div//img')[:src]
      puts "thumbnail => #{@thumbnail}"

      puts ""

    end

  end

end
