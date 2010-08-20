require 'open-uri'
require 'nokogiri'
require 'date'

require_relative 'model/init'

doc = Nokogiri::HTML open("http://blog.injekt.net/archive")

max = 24

doc.search("//li").each do |item|
  max -= 1
  max -= 1 if [21, 2].include?(max)
  date, title = item.text.match(/\s+\[([^\]]+)\] ([^\n]+)/).captures
  body = open("http://blog.injekt.net" + item.at("a")[:href] + '.txt').read
  time = Date.parse(date).to_time

  post = Post.new
  post.id = max
  post.title = title
  post.body = body
  post.draft = "0"
  post.created_at = time
  post.updated_at = time
  post.save
end
