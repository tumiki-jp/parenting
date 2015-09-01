# _*_ coding: utf-8 _*_
require './main/crawler/base/crawler.rb'

class CookCrawler < Crawler

  attr_reader :site_datas
  attr_reader :keywords

  def initialize()
    raise "not implement exception. please override initialize()"
  end

  def crawl()
    raise "not implement exception. please override crawl()"
  end

end

class CookSiteData

  attr_reader :url
  attr_reader :title
  attr_reader :description
  attr_reader :tags
  attr_reader :release_date
  attr_reader :thumbnail

  def initialize(args={})
  end
end