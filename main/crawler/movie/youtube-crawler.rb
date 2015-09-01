# _*_ coding: utf-8 _*_
require './main/crawler/base/movie-crawler.rb'

class YouTubeCrawler < MovieCrawler

  def initialize()
    @site_url = "https://www.youtube.com/"
    @keywords = [
      "子育て 1歳",
      "離乳食",
    ]

  end

  def crawl()

    @keywords.each do |keyword|

      # Step 2 Set parenting word to search box
      puts "search #{keyword}"
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
        if title.include?("猫") || title.include?("犬")
          puts "Skip #{url}"
          next
        end
        if has_selector?(:xpath, '//*[@id="eow-description"]')
          description = find(:xpath, '//*[@id="eow-description"]').text
        else
          description = "説明なし"
        end
        if description.include?("猫") || description.include?("犬")
          puts "Skip #{url}"
          next
        end
        tags = []
        release_date = find(:xpath, '//*[@id="watch-uploader-info"]/strong').text
        view_count = find(:xpath, '//*[@id="watch7-views-info"]/div[1]').text
        if has_selector?(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span')
          like_count = find(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span').text
        else
          like_count = "0"
        end
        if has_selector?(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span')
          dislike_count = find(:xpath, '//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span').text
        else
          dislike_count = "0"
        end
        comments = "" #find(:xpath, '').text

        thumbnail = "" #find(:xpath, 'div//img')[:src]


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

        puts movie_site_data
      end
    end
  end

end
