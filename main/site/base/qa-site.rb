# _*_ coding: utf-8 _*_
require 'nokogiri'
require 'open-uri'
require 'uri'

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

class QASite
  include Capybara::DSL

  attr_reader :base_url
  attr_reader :url
  attr_reader :title
  attr_reader :description
  attr_reader :tags
  attr_reader :update_date
  attr_reader :view_count

  def initialize()
    raise "not implement exception. please override initialize()"
  end

  def run()
    raise "not implement exception. please override run()"
  end

end
