# _*_ coding: utf-8 _*_

require 'mecab'
require 'json'
require './main/library/util/document-analyzer.rb'
require './main/library/tfidf/tfidf.rb'


class TfidfParenting
  def initialize()
    @file_path = './main/library/tfidf/tfidf-parenting.json'
  end

  # key = documentを識別するためのキー。URLを渡す
  # document = 文書(文字列)を受け取る
  def get_parenting_tfidf(key, document)

      # step1 名詞を抽出する 例 { "単語A" => 2, "単語B" => 3, "単語C" => 1}
      words = DocumentAnalyzer.get_part_of_speech_exclude_number(document, /名詞/)
      # step2 まずはデータベース(jsonファイル)を更新
      update_database(key, words)
      # step3 TF-IDF値を求める
      tfidf_hash = get_tfidf(key)

      return tfidf_hash
  end

  private
  # ファイルを読み込む
  def read(file_path)
    json_data = open(file_path) { |io| JSON.load(io) }
    return json_data
  end
  # ファイルを保存する
  def write(file_path, json_data)
    open(file_path, 'w') { |io| io.write(JSON.pretty_generate(json_data)) }
  end

  def get_tfidf(key)
    # Step1 ファイルを読み込む
    json_data = read(@file_path)
    document_data = json_data[key]

    # Step2 TF-IDFの計算に必要な情報を取得する
    tfidf_result = Hash.new(0)
    count_of_documents = json_data.keys.length # ドキュメントの総数
    count_words_in_document = document_data.values.inject {|sum, n| sum + n } # ドキュメント内の単語の総数を取得する

    document_data.each do |word, count|
      count_any_word_in_document = count
      # 単語を含むドキュメントの数を取得する
      count_of_documents_that_contain_word = json_data.values.count { |words| words.keys.include?(word) }
      # 計算する
      tfidf = Tfidf.new()
      tfidf_result[word] = tfidf.tfidf(count_any_word_in_document, count_words_in_document,
                                     count_of_documents, count_of_documents_that_contain_word)
    end

    # step8 sort
    sorted_tfidf = tfidf_result.sort { |(k1, v1), (k2, v2)| v2 <=> v1 }
    # sortすると配列になるので再度、ハッシュに変換する
    sorted_tfidf = Hash[*sorted_tfidf.flatten]
  end

  def update_database(key, words)
    # step1 read
    json_data = read(@file_path)
    # step2 update
    json_data[key] = words
    # step3 write
    write(@file_path, json_data)
  end



end
