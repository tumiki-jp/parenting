# _*_ coding: utf-8 _*_

# TF-IDF
# ある文書や文字列の中で、最も重要な単語や
# 特徴的な単語を抽出するための計算法
#
# 例)TF-IDF
# ドキュメント内のワードＡ（子育て, 大変, 子育て, つらい, 育児, つらい）
# ドキュメント内のワードＢ（子育て、楽しい、離乳食、おいしい, 育児）
#   [ドキュメントＡのTF]
#     TF(単語)       = ドキュメント内の単語出現回数 / ドキュメント内の単語の総数
#     TF(子育て)     = 2 / 6 = 0.33
#     TF(大変)       = 1 / 6 = 0.16
#     TF(つらい)     = 2 / 6 = 0.33
#     TF(育児)       = 1 / 6 = 0.16
#   [ドキュメントＡのIDF]
#     IDF(単語)      = log(ドキュメントの総数 / 単語が出現する文書の回数)
#     IDF(子育て)    = log(2 / 2) = 0.00
#     IDF(大変)      = log(2 / 1) = 0.30
#     IDF(つらい)    = log(2 / 1) = 0.30
#     IDF(育児)      = log(2 / 2) = 0.00
#   [ドキュメントＡのTF-IDF]
#     TF-IDF(子育て) = 0.33 * 0.00 = 0.000
#     TF-IDF(大変)   = 0.16 * 0.30 = 0.0480
#     TF-IDF(つらい) = 0.33 * 0.30 = 0.099
#     TF-IDF(育児)   = 0.16 * 0.00 = 0.000
#

class Tfidf
  def initialize()
  end

  # TF値を求める(ドキュメント内の単語出現回数 / ドキュメント内の単語の総数)
  # word_count  = ドキュメント内の単語出現回数
  # words_total = ドキュメント内の単語の総数
  def tf(word_count, words_total)
    return word_count.to_f / words_total
  end

  # IDF値を求める(ドキュメントの総数 / 単語が出現する文書の数)
  # documents_total               = ドキュメントの総数
  # documents_included_word_count = 単語が出現する文書の回数
  def idf(documents_total, documents_included_word_count)
  n = documents_total.to_f / documents_included_word_count
  return Math.log(n)
  end

  def tfidf(word_count, words_total, documents_total, documents_included_word_count)
    tf = tf(word_count, words_total)
    idf = idf(documents_total, documents_included_word_count)
    return tf * idf
  end
end
