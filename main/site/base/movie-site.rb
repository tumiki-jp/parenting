# _*_ coding: utf-8 _*_

class MovieSite
  include Capybara::DSL

  attr_reader :base_url
  attr_reader :url
  attr_reader :title
  attr_reader :description
  attr_reader :tags
  attr_reader :release_date
  attr_reader :view_count
  attr_reader :like_count
  attr_reader :dislike_count
  attr_reader :comments
  attr_reader :thumbnail

  def initialize()
    raise "not implement exception. please override initialize()"
  end

  def run()
    raise "not implement exception. please override run()"
  end

end
