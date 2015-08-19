# _*_ coding: utf-8 _*_
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

# Site
require './main/site/site.rb'
require './main/site/base/movie-site.rb'
require './main/site/youtube-site.rb'

# Capybaraの初期設定
Capybara.current_driver = :selenium
Capybara.default_wait_time = 10

# ブラウザをGoogle Chromeに変更する
# Capybara.register_driver :selenium do |app|
#   # http://code.google.com/p/chromedriver/downloads/list
#   # sudo mv ~/Downloads/chromedriver /usr/bin/
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# -------------------------------------------------------
# クローリングするサイトを定義
# -------------------------------------------------------
sites = []
youtube = YouTubeSite.new
sites << Site.new(youtube)
# sites << Site.new(CookPadSite.new)
# sites << Site.new(YahooChiebukuroSite.new)
# sites << Site.new(HatenaBlogSite.new)

# -------------------------------------------------------
# 実行
# -------------------------------------------------------
sites.each do |site|
  site.run
end
