# _*_ coding: utf-8 _*_
require './main/crawler/base/qa-crawler.rb'

class YahooChiebukuroCrawler < QACrawler

  def initialize()
    @site_url = "http://chiebukuro.yahoo.co.jp/"
  end

  def crawl()

    # Step 2 Click category
    find(:xpath, '//*[@id="h_nav"]/ul/li[2]/a').click

    # Step 3 Click detail category
    find(:xpath, '//a[contains(text(), "子育ての悩み")]').click

    # Step 4 Filter
    find(:xpath, '//a[text()="解決済みの質問"]').click

    # Step 5 Sort
    sleep 1
    find(:xpath, '//a[text()="質問日時"]').click

    # Step 6 get metadata
    sleep 1

    #get category
    tags = []
    tags << all(:xpath, '//div[@class="topicPass clrfx"]/ol/li/a/span').last.text

    all(:xpath, '//*[@id="qalst"]/li').each do |element|
      url = element.find(:xpath, 'dl/dt/a')[:href]
      title = element.find(:xpath, 'dl/dt/a').text
      update_date = element.find(:xpath, 'dl/dd[1]').text.split('-')[0]

      qa_site_data = QASiteData.new(
      url: url,
      title: title,
      tags: tags,
      update_date: update_date)

      puts qa_site_data
    end

  end

end
