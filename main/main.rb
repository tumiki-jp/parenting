# _*_ coding: utf-8 _*_

# Site
require './main/crawler/movie/youtube-crawler.rb'
require './main/crawler/cook/cookpad-crawler.rb'
require './main/crawler/qa/yahoochiebukuro-crawler.rb'
# Dir[File.expand_path('../commands', __FILE__) << '/*.rb'].each do |file|
#   require file
# end

# -------------------------------------------------------
# クローリングするサイトを定義
# -------------------------------------------------------
crawlers = []
crawlers << YouTubeCrawler.new
crawlers << CookpadCrawler.new
crawlers << YahooChiebukuroCrawler.new

# -------------------------------------------------------
# 実行
# -------------------------------------------------------
crawlers.each do |crawler|
  crawler.run
end
#
# str = "2015/10/16 に公開
# ORIアカデミー
# oriacademy.com
# ★初めての子育て0歳講座
#
# ORIORIチャンネル　天才育児通信教育♬
# 赤ちゃんが生まれたら、準備したいもの１ヶ月講座（サンプル動画）
#
# ORIORIチャンネル　天才育児講座7ヶ月から、、、、思い通りに動く手、運動の準備、言葉と数の習得、など­（サンプル動画です！）
# https://www.youtube.com/watch?v=_i-Wn...
#
# ★いまからやりたい1歳講座（サンプル動画はお問い合わせください！こちら👆）
# ★2歳までに揃えたいもの講座（サンプル動画はお問い合わせください！こちら👆）
#
# ORIORIチャンネル　自立する環境作り（サンプル動画）
#
# https://www.youtube.com/watch?v=c0DOA...
#
# ★3歳からはこう育てよう講座（サンプル動画はお問い合わせください！こちら👆）
# ★4歳のあふれる’やる気’に応えよう講座（サンプル動画はお問い合わせください！こ­ちら👆）
# ★5歳から育てたいあふれる’学び’講座（サンプル動画はお問い合わせください！こち­ら👆）
# ★6歳までに始めたいこんなこと講座（サンプル動画はお問い合わせください！こちら👆­）
#
# ★バイリンガル育児講座
#
# ORIORIチャンネル　バイリンガル育児の秘訣講座（サンプル動画）
#
# https://www.youtube.com/watch?v=eeKg3...
#
# 続きは、お申し込み後に！
# ママが先生ORIアカデミーを家で実践、通信教育受付中★
# 申し込み、ご質問はこちら👆
# https://www.youtube.com/watch?v=ltK4N...
# 申し込み、ご質問はこちら👆
# "
#
# str = "
# 2015/10/02 に公開
# 「おと絵本」の動画」
# →https://www.youtube.com/watch?v=Br7Td...
# １歳２ヶ月号の絵本
# →https://www.youtube.com/watch?v=6QLVA...
#
# 【子供の能力はほぼ三歳までの
# 過ごし方で決まってしまうと言われています。】
# 知育、育脳。。。興味はあるけどなかなか時間が。。。
# そう思っているうちにも時間は過ぎ去って行きます。
# この瞬間はもう二度と戻ってこないのです。
# だから、後悔しないように
# 子供の為に一緒にいる時間を増やしませんか？
# 下の↓URLをクリックして
# 登録したメアドに一緒の時間を増やす方法が
# 無料で送られてきます。
# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# 《限定無料》⇒http://qq4q.biz/neiz
# 【限定につき予告なく終了する場合が有ります】
# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# これを習得すれば経済的将来の不安が消えます。
# 保育園に入れてもパート代が飛ぶだけで無意味。
# 日本の経済状況を理解している賢い人はもう始めています！
# 会社に行くより、自分で好きな時間に稼ぐ方法を身につけることは将来必須スキルになり­ます！！
# 【情報は無料でご登録のメールアドレスにお届けします】
# 《フリーメールでもOK！》⇒http://qq4q.biz/neiz
#
# 【関連動画】
# こどもちゃれんじ　いろっちとあそぼう！
# https://www.youtube.com/watch?v=BgQ7D...
#
# ・【こどもちゃれんじ】[名曲]てと　てを　つないで♪ （ともだちVer.）
# https://www.youtube.com/watch?v=MC-K5...
#
#
# ・こどもちゃれんじ　かずのドーナツやさん Dounuts shop
# https://www.youtube.com/watch?v=CuuYB...
#
#
# ・【こどもちゃれんじ】[名曲]サンバでピザ♪
# https://www.youtube.com/watch?v=Bg9nn...
#
# 【関連キーワード】
# こどもちゃれんじ 相談こどもちゃれんじ 卒園ソングこどもちゃれんじ 送付先変更こどもちゃれんじ 卒園の歌こどもちゃれんじ 祖父母こどもちゃれんじ まなおねえさんこどもちゃれんじ マグポーチこどもちゃれんじ ままごとこどもちゃれんじ 漫画こどもちゃれんじ マイページこどもちゃれんじ 評判こどもちゃれんじ 費用こどもちゃれんじ ひらがなこどもちゃれんじ ひらがなタッチこどもちゃれんじ 必要こどもちゃれんじ ヤフオクこどもちゃれんじ やめどきこどもちゃれんじ やめるこどもちゃれんじ 辞め方こどもちゃれんじ 辞めたこどもちゃれんじ 声優こどもちゃれんじ 先行こどもちゃれんじ 成果こどもちゃれんじ 整理こどもちゃれんじ 制作モニターこどもちゃれんじ 無料こどもちゃれんじ 難しいこどもちゃれんじ 無駄こどもちゃれんじ ムッシュこどもちゃれんじ 無料ゲームこどもちゃれんじ 口コミこどもちゃれんじ クリスマスコンサートこどもちゃれんじ くもんこどもちゃれんじ 靴こどもちゃれんじ クリスマス特大号こどもちゃれんじ 問い合わせこどもちゃれんじ 友達紹介こどもちゃれんじ トイレトレーニングこどもちゃれんじ 特別号こどもちゃれんじ 途中入会こどもちゃれんじ 返品こどもちゃれんじ 変更こどもちゃれんじ 返金こどもちゃれんじ 弊
# "
# # require './main/debug/debugger.rb'
# # Debugger.debug_puts_parse(str)
# require './main/library/util/document-analyzer.rb'
#
# # target = /名詞,一般|名詞,固有名詞/
# # p DocumentAnalyzer.get_part_of_speech_with_adjective(str, target)
# #
# require './main/library/tfidf/tfidf-parenting.rb'
# tfidf = TfidfParenting.new()
# p tfidf.get_parenting_tfidf("hoge", str)
