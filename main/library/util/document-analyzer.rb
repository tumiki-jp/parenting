# _*_ coding: utf-8 _*_

class DocumentAnalyzer
  def initialize()
  end

  # ドキュメントから年齢を抽出するメソッド
  # 「全角数字」は「半角数字」に、「才」は「歳」に自動で置換します。
  # 重複は排除します。
  def self.get_ages(document)
    ages = []
    # Example => http://rubular.com/r/ImCveuoYTF
    document.scan(/(([0-9０-９]+(歳|才|[カヵかケヶ]月))+)/) do |match|
      age = match[0]
      age = age.tr('０-９', '0-9') if age =~ /[０-９]+/
      age = age.gsub!('才', '歳') if age =~ /才/
      age = age.gsub!('ケ月', 'ヶ月') if age =~ /ケ月/
      age = age.gsub!('ヵ月', 'ヶ月') if age =~ /ヵ月/
      age = age.gsub!('カ月', 'ヶ月') if age =~ /カ月/
      age = age.gsub!('か月', 'ヶ月') if age =~ /か月/
      ages.push(age)
    end
    return ages.uniq #重複は排除する
  end

  # ドキュメントから指定した品詞を抽出するメソッド
  # part_of_speech_patternには正規表現を指定する /名詞|動詞|形容詞/
  # 戻り値は単語ごとの出現回数を持ったハッシュ { "単語A" => 1, "単語B" => 3, "単語C" => 2}
  def self.get_part_of_speech(document, part_of_speech_pattern)
    # step1 Mecabで構文解析
    mecab = MeCab::Tagger.new("-Ochasen -d /usr/local/Cellar/mecab/0.996/lib/mecab/dic/mecab-ipadic-neologd")
    parseNode = mecab.parseToNode(document)
    # step2 引数で受け取った品詞で絞り込み
    filtered_words = []
    while parseNode
      filtered_words.push(parseNode.surface) if part_of_speech_pattern =~ parseNode.feature.split(/,/)[0]
      parseNode = parseNode.next
    end
    # step3 単語ごとに出現回数を集計する
    words_count_hash = Hash.new(0)
    filtered_words.each do |word|
      words_count_hash[word] += 1
    end
    return words_count_hash
  end

  # ドキュメントから指定した品詞(数値は除く)を抽出するメソッド
  # part_of_speech_patternには正規表現を指定する /名詞|動詞|形容詞/
  # 戻り値は単語ごとの出現回数を持ったハッシュ { "単語A" => 1, "単語B" => 3, "単語C" => 2}
  def self.get_part_of_speech_exclude_number(document, part_of_speech_pattern)
    # step1 Mecabで構文解析
    mecab = MeCab::Tagger.new("-Ochasen -d /usr/local/Cellar/mecab/0.996/lib/mecab/dic/mecab-ipadic-neologd")
    parseNode = mecab.parseToNode(document)
    # step2 引数で受け取った品詞で絞り込み
    filtered_words = []
    while parseNode
      filtered_words.push(parseNode.surface) if part_of_speech_pattern =~ parseNode.feature.split(/,/)[0]
      parseNode = parseNode.next
    end
    # step3 単語ごとに出現回数を集計する
    words_count_hash = Hash.new(0)
    filtered_words.each do |word|
      words_count_hash[word] += 1
    end
    # step4 数値を除く
    words_count_hash.delete("0")
    words_count_hash.delete("1")
    words_count_hash.delete("2")
    words_count_hash.delete("3")
    words_count_hash.delete("4")
    words_count_hash.delete("5")
    words_count_hash.delete("6")
    words_count_hash.delete("7")
    words_count_hash.delete("8")
    words_count_hash.delete("9")

    return words_count_hash
  end
end
