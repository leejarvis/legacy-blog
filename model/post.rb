require 'rdiscount'
require 'time'

class Post < Sequel::Model
  many_to_one :user
  many_to_many :tags, join_table: "post_tags"

  def self.latest(n)
    filter(draft: 0).order_by(:created_at.desc).limit(n).all
  end

  def validate
    validates_presence [:title, :body, :draft]

    validates_format /\d/, :draft
    validates_format /\d/, :comments

    validates_min_length 5,   :title
    validates_min_length 200, :body
  end

  def url_title
    title.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9_-]/, '').downcase
  end

  def url
    "/#{id}/#{url_title}"
  end

  def href
    %Q{<a href="#{url}">#{title}</a>}
  end

  def summary
    content.split("</p>").first(2).join("</p>") + '..</p>'
  end

  def content
    RDiscount.new(body).to_html
  end

  def tag_names
    tags.map(&:name)
  end

  def tags_str
    tag_names.join(', ')
  end

  def tag_links
    tag_names.map do |tag|
      %Q{<a class="tag small" href="/tag/#{Rack::Utils.escape(tag)}">#{tag}</a>}
    end.join(' ')
  end

  def timestamp
    created_at.strftime("%B %d, %Y")
  end
end
