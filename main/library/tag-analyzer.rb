# _*_ coding: utf-8 _*_

require './main/library/util/document-analyzer.rb'
require './main/library/tfidf/tfidf-parenting.rb'

class TagGenerator
  def self.parse(url, document)
    tags = []

    # step tfidf値の高い単語３つをタグにする
    tfidf_parenting = TfidfParenting.new()
    sorted_tfidf = tfidf_parenting.get_parenting_tfidf(url, document)
    tags += sorted_tfidf.keys.take(3)

    # 対象年齢の取得
    ages = DocumentAnalyzer.get_ages(document)
    tags += ages if !ages.nil?

    return tags
  end
end
