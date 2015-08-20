# _*_ coding: utf-8 _*_

class CookpadSite < CookSite

  def initialize()
    puts "CookpadSite#initialize"

    @base_url = "https://www.cookpad.com/"
  end

  def run()

    # Step 1 Show web site
    visit(@base_url)

    # Step 2 Set parenting word to search box
    find(:xpath, '//*[@id="keyword"]').set("離乳食")

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
    puts urls

    count = 0
    urls.each do |url|

      # Step 7 Get metadata
      visit(url)
      #sleep 1
      count += 1
      puts count

      @url = url
      @title = find(:xpath, '//*[@id="recipe-title"]/h1').text
      @description = find(:xpath, '//*[@id="description"]/div[1]').text
      @tags = []
      @release_date = find(:xpath, '//*[@id="published_date"]').text
      @thumbnail = find(:xpath, '//*[@id="main-photo"]/img')[:src]

      puts "url => #{@url}"
      puts "title => #{@title}"
      puts "description => #{@description}"
      puts "tags => #{@tags}"
      puts "release_date => #{@release_date}"
      puts "thumbnail => #{@thumbnail}"

      puts ""

    end

  end

end
