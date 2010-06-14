require 'sinatra/base'
require 'haml'
require 'yaml'

require 'db/init'
require 'model/post'
require 'model/user'

class Blog < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/view'
  set :public, File.dirname(__FILE__) + '/public'
  enable :method_override, :sessions

  get '/' do
    @posts = Post.last(10)
    haml :index
  end

  get '/login' do
    haml :login
  end

  post '/login' do
    login(params[:username], params[:password])
  end

  get '/logout' do
    requires_auth
    logout
  end

  get '/edit/:post_id' do |id|
    not_found unless @post = Post[id.to_i]
    requires_auth
    haml :edit
  end

  put '/edit' do
    not_found unless post = Post[params[:id].to_i]
    requires_auth

    post.title = params[:title]
    post.body = params[:body]

    if post.valid?
      user.add_post(post)
    else
      puts "Bad post .."
    end

    redirect post.url
  end

  get '/new' do
    requires_auth
    haml :new
  end

  post '/new' do
    requires_auth
    post = Post.new
    post.title = params[:title]
    post.body = params[:body]

    if post.valid?
      user.add_post(post)
    else
      puts "bad post .."
    end

    redirect post.url
  end

  get '/delete/:id' do |id|
    not_found unless post = Post[id.to_i]
    requires_auth
    post.delete
    redirect '/'
  end

  get '/:id' do |id|
    not_found unless post = Post[id.to_i]
    redirect post.url
  end

  get '/:id/:title.:format' do |id, title, format|
    not_found unless post = Post[id.to_i]

    case format.to_sym
    when :yml
      content_type :yml
      post.to_yaml
    when :json
      content_type :json
      post.to_json
    when :xml
      content_type :xml
      post.to_xml
    when :txt
      content_type :txt
      post.body
    end
  end

  get '/:id/:title' do |id, title|
    not_found unless @post = Post[id.to_i]
    haml :post
  end

  not_found do
    haml :"404", :layout => false
  end

  error do
    haml :"404", :layout => false
  end

  helpers do
    def login(user, pass)
      if User.authenticate(user, pass)
        session[:logged_in] = true
        session[:user] = user
      end
      redirect '/'
    end

    def user
      User[:username => session[:user]]
    end

    def logout
      session[:logged_in] = false
      session[:user] = nil
      redirect '/'
    end

    def logged_in?
      session[:logged_in]
    end

    def requires_auth
      redirect '/' unless logged_in?
    end
  end
end

