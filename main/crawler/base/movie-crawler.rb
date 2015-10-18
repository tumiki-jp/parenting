# _*_ coding: utf-8 _*_
require './main/crawler/base/crawler.rb'
require './main/library/tag-analyzer.rb'

class MovieCrawler < Crawler

  attr_reader :keywords

  def initialize()
    raise "not implement exception. please override initialize()"
  end

  def crawl_base()
    # load crawler settings
    crawler_settings = YAML.load_file('./main/config/crawler-settings.yml')
    @keywords = crawler_settings["movie_crawler"]["search_word"]

    crawler_datas = []
    @keywords.each do |keyword|
      puts "#{Time.new()} : CRAWL KEYWORD => #{keyword}"
      movie_site_datas = crawl_movie(keyword)
      crawler_datas.concat(movie_site_datas) if !movie_site_datas.nil?
    end
    return crawler_datas
  end

  def creansing_base(crawler_datas)
    cleansing_datas = []
    crawler_datas.each do |crawler_data|
      cleansing_data = creansing_movie(crawler_data)
      cleansing_datas.push(cleansing_data) if !cleansing_data.nil?
    end
    return cleansing_datas
  end

  def cast_type_base(creansing_datas)
    creansing_datas.each do |data|
      # cast
      data.view_count = data.view_count.to_i
      data.like_count = data.like_count.to_i
      data.dislike_count = data.dislike_count.to_i
    end
    return creansing_datas
  end

  def generate_tags_base(cast_datas)
    cast_datas.each do |data|
      # 先に文字列を一つにくっつけておくほうがいいかなと思った
      source = data.title + data.description

      tags = TagGenerator.parse(data.url, source)
      data.tags += tags
      data.tags.uniq!
      puts "#{Time.new()} : GENERATED TAGS => #{tags}; UPDATED TAGS => #{data.tags}"
    end
    return cast_datas
  end

  def save_data_base(connection, generate_tags_datas)
    query_update = "UPDATE movie_site_data
                    SET    title = $1,
                           description = $2,
                           tags = $3,
                           release_date = $4,
                           view_count = $5,
                           like_count = $6,
                           dislike_count = $7,
                           comments = $8,
                           thumbnail = $9
                    WHERE  url = $10;"

    query_insert = "INSERT INTO movie_site_data (url, title, description, tags, release_date,
    view_count, like_count, dislike_count, comments, thumbnail)
    SELECT $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
    WHERE  NOT EXISTS(SELECT * FROM movie_site_data WHERE url = $1);"

    updated_record = 0
    inserted_record = 0
    puts "#{Time.new()} : UPDATE DATAS => #{generate_tags_datas}"
    generate_tags_datas.each do |data|
      # ------------------------------------------------
      # execute
      # ------------------------------------------------
      result = connection.exec(query_update, [data.title, data.description, data.tags,
      data.release_date, data.view_count, data.like_count, data.dislike_count,
      data.comments, data.thumbnail, data.url])
      updated_record += result.cmdtuples

      result = connection.exec(query_insert, [data.url, data.title, data.description, data.tags,
      data.release_date, data.view_count, data.like_count, data.dislike_count,
      data.comments, data.thumbnail])
      inserted_record += result.cmdtuples
    end
    puts "#{Time.new()} : UPDATED QUERY #{updated_record} datas"
    puts "#{Time.new()} : INSERTED QUERY #{inserted_record} datas"
  end







  def crawl_movie()
    raise "not implement exception. please override crawl_movie()"
  end

  def creansing_movie(crawler_datas)
    raise "not implement exception. please override creansing_movie(crawler_datas)"
  end

  def save_data_movie(creansing_datas)
    raise "not implement exception. please override save_data_movie(creansing_datas)"
  end

end

class MovieSiteData

  attr_accessor :url
  attr_accessor :title
  attr_accessor :description
  attr_accessor :tags
  attr_accessor :release_date
  attr_accessor :view_count
  attr_accessor :like_count
  attr_accessor :dislike_count
  attr_accessor :comments
  attr_accessor :thumbnail

  def initialize(args)
    @url = args[:url]
    @title = args[:title]
    @description = args[:description]
    @tags = args[:tags]
    @release_date = args[:release_date]
    @view_count = args[:view_count]
    @like_count = args[:like_count]
    @dislike_count = args[:dislike_count]
    @comments = args[:comments]
    @thumbnail = args[:thumbnail]
  end

end
