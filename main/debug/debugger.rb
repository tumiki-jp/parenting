# _*_ coding: utf-8 _*_

require 'mecab'

# 開発時に使えるメソッドを集めたクラス
class Debugger

  def self.debug_puts_parse(contents)
    mecab = MeCab::Tagger.new("-Ochasen -d /usr/local/Cellar/mecab/0.996/lib/mecab/dic/mecab-ipadic-neologd")
    parseNode = mecab.parseToNode(contents)
    while parseNode
      puts "#{parseNode.surface} #{parseNode.feature}"
      parseNode = parseNode.next
    end
  end

  def self.debug_parse_surface(contents)
    mecab = MeCab::Tagger.new("-Ochasen -d /usr/local/Cellar/mecab/0.996/lib/mecab/dic/mecab-ipadic-neologd")
    parseNode = mecab.parseToNode(contents)
    result = []
    while parseNode
      result.push(parseNode.surface)
      parseNode = parseNode.next
    end
    return result
  end

  def self.read_json_data()
    json_data = open("./main/library/tfidf-parenting.json") { |io| JSON.load(io) }
    return json_data
  end
end
