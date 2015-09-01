# _*_ coding: utf-8 _*_
require './main/crawler/base/cook-crawler.rb'

class CookpadCrawler < CookCrawler

  def initialize()
    @site_url = "https://www.cookpad.com/"
    @keywords = [
      "離乳食",
      "幼児食",
    ]
  end

  def crawl()

    @keywords.each do |keyword|

      # Step 2 Set parenting word to search box
      find(:xpath, '//*[@id="keyword"]').set(keyword)

      # Step 3 Click search button
      find(:xpath, '//*[@id="submit_button"]').click

      # Step 4 Filter to XXXXX

      # Step 5 Sort with XXXXX

      # Step 6 navigate to movie page
      sleep 1
      urls = []
      all(:xpath, '//div[@id="main_content"]/div[@class="recipe-preview"]/div[@class="recipe-text"]/span[1]/a').each do |movie_element|
        urls << movie_element[:href]
      end

      urls.each do |url|

        # Step 7 Get metadata
        visit(url)

        sleep(1)
        title = find(:xpath, '//*[@id="recipe-title"]/h1').text
        description = find(:xpath, '//*[@id="description"]/div[1]').text
        tags = []
        release_date = find(:xpath, '//*[@id="published_date"]').text
        thumbnail = find(:xpath, '//*[@id="main-photo"]/img')[:src]


        cook_site_data = CookSiteData.new(
        url: url,
        title: title,
        description: description,
        tags: tags,
        release_date: release_date,
        thumbnail: thumbnail)

        puts cook_site_data
      end
    end
  end

end
