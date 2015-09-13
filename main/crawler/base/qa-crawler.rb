# _*_ coding: utf-8 _*_
require './main/crawler/base/crawler.rb'

class QACrawler < Crawler



  def initialize()
    raise "not implement exception. please override initialize()"
  end

  def crawl_base()
    crawler_datas = []
    qa_site_datas = crawl_qa()
    crawler_datas.concat(qa_site_datas) if !qa_site_datas.nil?
    return crawler_datas
  end

  def creansing_base(crawler_datas)
    cleansing_datas = []
    crawler_datas.each do |crawler_data|
      cleansing_data = creansing_qa(crawler_data)
      cleansing_datas.push(cleansing_data) if !cleansing_data.nil?
    end
    return cleansing_datas
  end

  def save_data_base(connection, creansing_datas)
    query = "INSERT INTO qa_site_data (url, title, tags, update_date) VALUES($1, $2, $3, $4)"

    creansing_datas.each do |data|
      # cast

      # execute
      connection.exec(query, [data.url, data.title, data.tags, data.update_date])
    end
  end






  def crawl_qa()
    raise "not implement exception. please override crawl_qa()"
  end

  def creansing_qa(crawler_datas)
    raise "not implement exception. please override creansing_qa(crawler_datas)"
  end

  def save_data_qa(creansing_datas)
    raise "not implement exception. please override save_data_qa(creansing_datas)"
  end

end

class QASiteData
  attr_reader :url
  attr_reader :title
  attr_reader :tags
  attr_reader :update_date

  def initialize(args)
    @url = args[:url]
    @title = args[:title]
    @tags = args[:tags]
    @update_date = args[:update_date]
  end
end
