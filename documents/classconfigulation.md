main.rb
  rubyを実行するmainクラス

crawler.rb
  クローラーの大元のクラス

MovieSite
  YouTubeSite

CookSite
  CookPadSite

QASite
  YahooChiebukuroSite

BlogSite
  HatenaBlogSite
  AmebaBlogSite

NewsSite
  NikkeiNewsSite

[library]
  tfidf.rb … TF-IDF値を計算する
  tfidf-parenting.rb … Parenting(子育て)のTF-IDF値を計算する。
                        データ(ドキュメント)を渡したら、そのデータの単語毎のtfidfをハッシュで返す
  tfidf-parenting.json … クローラーで収集したデータ毎の単語情報を保持する。
                          IDF値の計算で使用する。
