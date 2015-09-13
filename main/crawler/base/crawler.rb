# _*_ coding: utf-8 _*_
require 'pg'
require './main/config/capybara-config.rb'

class Crawler
  #
  include Capybara::DSL

  # サイトトップページのURL
  attr_reader :site_url

  def initialize()
    puts "Crawler initialize()"
  end

  def run()
    puts "#{Time.new()} : ================================== RUN #{ self.class.name }=================================="

    # first step - Show web site
    puts "#{Time.new()} : VISIT #{@site_url}"
    visit(@site_url)

    # second step - Start Crawl
    puts "#{Time.new()} : START CRAWLER"
    crawler_datas = crawl_base()
    puts "#{Time.new()} : END CRAWLER #{crawler_datas.length} datas"

    # third step - Data creansing
    puts "#{Time.new()} : START CREANSING #{crawler_datas.length} datas"
    creansing_datas = creansing_base(crawler_datas)
    puts "#{Time.new()} : END CREANSING #{creansing_datas.length} datas"

    # fourth step - save to database
    puts "#{Time.new()} : START SAVE"
    save_base(creansing_datas)
    puts "#{Time.new()} : END SAVE"
  end

  def crawl_base()
    raise "not implement exception. please override crawl_base()"
  end

  def creansing_base(crawler_datas)
    raise "not implement exception. please override creansing_base(crawler_datas)"
  end

  def save_base(creansing_datas)
    # connect
    connection = PG::connect(:host => "localhost", :user => "parenting_user", :password => "parenting_password", :dbname => "parenting", :port => "5432")
    begin
      save_data_base(connection, creansing_datas)
    ensure
      connection.finish
    end
  end

  def save_data_base(connection, creansing_datas)
    raise "not implement exception. please override save_data_base(connection, creansing_data)"
  end

end
