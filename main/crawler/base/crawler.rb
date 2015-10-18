# _*_ coding: utf-8 _*_
require 'pg'
require './main/config/capybara-config.rb'
require 'yaml'

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
    result_datas = crawl_base()
    puts "#{Time.new()} : END CRAWLER #{result_datas.length} datas"

    # third step - Data creansing
    puts "#{Time.new()} : START CREANSING #{result_datas.length} datas"
    result_datas = creansing_base(result_datas)
    puts "#{Time.new()} : END CREANSING #{result_datas.length} datas"

    # fourth step - cast type
    puts "#{Time.new()} : START CAST "
    result_datas = cast_type_base(result_datas)
    puts "#{Time.new()} : END CAST "

    # fifth step - auto generate of tags
    puts "#{Time.new()} : START GENERATE OF TAG "
    puts "#{Time.new()} : PREVIOUS UPDATE DATAS => #{result_datas}"
    result_datas = generate_tags_base(result_datas)
    puts "#{Time.new()} : END GENERATE OF TAG "

    # sixth step - save to database
    puts "#{Time.new()} : START SAVE"
    save_base(result_datas)
    puts "#{Time.new()} : END SAVE"

  end

  def crawl_base()
    raise "not implement exception. please override crawl_base()"
  end

  def creansing_base(crawler_datas)
    raise "not implement exception. please override creansing_base(crawler_datas)"
  end

  def cast_type_base(creansin_datas)
    raise "not implement exception. please override cast_type_base(creansing_datas)"
  end

  def generate_tags_base(cast_type_datas)
    raise "not implement exception. please override cast_type_base(cast_type_datas)"
  end

  def save_base(generate_tags_datas)
    # connect
    connection = PG::connect(:host => "localhost", :user => "parenting_user", :password => "parenting_password", :dbname => "parenting", :port => "5432")
    begin
      save_data_base(connection, generate_tags_datas)
    ensure
      connection.finish
    end
  end

  def save_data_base(connection, cast_datas)
    raise "not implement exception. please override save_data_base(connection, generate_tags_datas)"
  end

end
