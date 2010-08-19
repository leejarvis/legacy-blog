class Tag < Sequel::Model
  many_to_many :posts, join_table: "post_tags"

  def self.all_links
    all.map do |tag|
      %Q{<a class="tag" href="/tag/#{Rack::Utils.escape(tag.name)}">#{tag.name}</a>}
    end.join(' ')
  end
end
