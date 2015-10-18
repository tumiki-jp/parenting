# _*_ coding: utf-8 _*_
require './main/crawler/base/movie-crawler.rb'

class YouTubeCrawler < MovieCrawler

  def initialize()
    @site_url = "https://www.youtube.com/"

  end

  def crawl_movie(keyword)
    movie_site_datas = []

    # Step 2 Set parenting word to search box
    find(:xpath, '//*[@id="masthead-search-term"]').set(keyword)
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

    urls.each do |url|
      # Step 7 Get metadata
      visit(url)

      sleep 1
      title = find(:xpath, '//*[@id="eow-title"]')[:title]
      description = find(:xpath, '//*[@id="eow-description"]').text if has_selector?(:xpath, '//*[@id="eow-description"]')
      tags = []
      release_date = find(:xpath, '//*[@id="watch-uploader-info"]/strong').text
      view_count = find(:xpath, '//*[@id="watch7-views-info"]/div[1]').text
      like_count = find(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span').text if has_selector?(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span')
      dislike_count = find(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span').text if has_selector?(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span')
      comments = ""
      thumbnail = ""

      movie_site_data = MovieSiteData.new(
      url: url,
      title: title,
      description: description,
      tags: tags,
      release_date: release_date,
      view_count: view_count,
      like_count: like_count,
      dislike_count: dislike_count,
      comments: comments,
      thumbnail: thumbnail)

      movie_site_datas.push(movie_site_data)
    end

    return movie_site_datas
  end

  def creansing_movie(crawler_data)

    # title
    if crawler_data.title.include?("猫") || crawler_data.title.include?("犬")
      puts "#{Time.new()} : Skip #{crawler_data.url} this title include 猫, 犬"
      return nil
    end

    # description
    crawler_data.description = "説明なし" if crawler_data.description.nil?
    if crawler_data.description.include?("猫") || crawler_data.description.include?("犬")
      puts "#{Time.new()} : Skip #{crawler_data.url} this description include 猫, 犬"
      return nil
    end

    # release_date
    # 2015/01/01 に公開
    crawler_data.release_date.slice!(" に公開")

    # view_count
    # 視聴回数 28 回
    if match = crawler_data.view_count.match(/視聴回数 ([0-9]+) 回/)
      crawler_data.view_count = match[1]
    end

    # like_count
    crawler_data.like_count = "0" if crawler_data.like_count.nil?

    # dislike_count
    crawler_data.dislike_count = "0" if crawler_data.dislike_count.nil?

    return crawler_data
  end

end
