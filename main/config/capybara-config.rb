# _*_ coding: utf-8 _*_

require 'nokogiri'
require 'open-uri'
require 'uri'

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

# Capybaraの初期設定
Capybara.current_driver = :selenium
Capybara.default_wait_time = 10

# ブラウザをFirefoxからGoogle Chromeに変更する
# Capybara.register_driver :selenium do |app|
#   # http://code.google.com/p/chromedriver/downloads/list
#   # sudo mv ~/Downloads/chromedriver /usr/bin/
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
