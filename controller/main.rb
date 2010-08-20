class Main < Controller
  map '/'
  
  def index(*args)
    case args.size
    when 1, 2
      if post = Post[args.shift]
        render_view(:post, post: post)
      else
        not_found
      end
    else
      render_view(:posts, posts: Post.latest(request[:n] || 10))
    end
  end

  def archive
    @posts = Post.order_by(:created_at.desc).all
  end

  def post(id)
    @post = Post[id]
  end

  def feed
    @posts = Post.order_by(:created_at.desc).all
    @updated = @posts.last.updated_at
  end

  def tag(tagstr)
    not_found unless tag = Tag[:name => Rack::Utils.unescape(tagstr)]
    render_view(:posts, posts: tag.posts, tag: tag)
  end

  def login
    return unless request.post?
    user_login(request.subset(:username, :password))
    if logged_in?
      flash[:notice] = "You're now logged in as #{user.username}"
      redirect Admin.r(:/)
    else
      flash[:error] = "Unable to login"
      redirect r(:/)
    end
  end

  def logout
    user_logout
    redirect_referrer
  end
end
