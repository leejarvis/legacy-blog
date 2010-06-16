require 'rdiscount'
require 'time'

class Post < Sequel::Model
  many_to_one :user

  def self.add(title, author, body)
    create :title => title, :author => author, :body => body
  end

  def self.last(n=1)
    order_by(:created_at.desc).limit(n).all
  end

  def url_title
    title.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9_-]/, '').downcase
  end

  def url
    "/#{id}/#{url_title}"
  end

  def summary(n=400)
    content[0..n] + '...'
  end

  def content
    RDiscount.new(body).to_html
  end

  def timestamp
    created_at.strftime("%B %d, %Y")
  end

  def self.last_updated_timestamp
    order_by(:created_at.desc).limit(1).first.created_at.xmlschema
  end
end

