class Admin < Controller
  map '/admin'

  before_all { redirect "/" unless logged_in? }
  
  def index
    if action = request[:action]
      id = request[:id]
      case action
      when "edit"
        @post = Post[id]
        @edit = true
      when "delete"
        Post[id].delete
        flash[:notice] = "Post deleted"
        redirect_referrer
      when "delete-tag"
        Tag[id].delete
        flash[:notice] = "Tag removed"
        redirect_referrer
      end
    end

    @tags = Tag.all
  end

  # add post
  def post
    redirect r(:/) unless request.post?

    values = request.params
    values["draft"] ||= "0"
    tags = values.delete("tags")
    action = values.delete("action")
    id = values.delete("id")
    
    if action and action == "edit"
      post = Post[id]
    else
      post = Post.new(values)
    end

    if post.valid?
      if action == "edit"
        post.update(values)
      else
        user.add_post(post)
      end

      tags.split(/\s*,\s*/).each do |tag|
        next if post.tags.map(&:name).include?(tag)
        post.add_tag(Tag.find_or_create(name: tag))
      end

      flash[:notice] = "Post #{action == "edit" ? 'updated' : 'created'}"
      redirect Main.r(post.url)
    else
      flash[:error] = post.errors.full_messages.join("<br />")
      redirect_referrer
    end

    redirect r(:/)
  end
end
