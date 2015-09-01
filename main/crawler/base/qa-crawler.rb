# _*_ coding: utf-8 _*_
require './main/crawler/base/crawler.rb'

class QACrawler < Crawler

  attr_reader :site_datas

  def initialize()
    raise "not implement exception. please override initialize()"
  end

  def crawl()
    raise "not implement exception. please override crawl()"
  end

end

class QASiteData
  attr_reader :url
  attr_reader :title
  attr_reader :tags
  attr_reader :update_date

  def initialize(args={})
  end
end
