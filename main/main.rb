# _*_ coding: utf-8 _*_

# Site
require './main/crawler/movie/youtube-crawler.rb'
require './main/crawler/cook/cookpad-crawler.rb'
require './main/crawler/qa/yahoochiebukuro-crawler.rb'
# Dir[File.expand_path('../commands', __FILE__) << '/*.rb'].each do |file|
#   require file
# end

# -------------------------------------------------------
# クローリングするサイトを定義
# -------------------------------------------------------
crawlers = []
crawlers << YouTubeCrawler.new
crawlers << CookpadCrawler.new
crawlers << YahooChiebukuroCrawler.new

# -------------------------------------------------------
# 実行
# -------------------------------------------------------
crawlers.each do |crawler|
  crawler.run
end
