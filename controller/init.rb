class Controller < Ramaze::Controller
  map_layouts '/'
  layout :default
  helper :xhtml, :cgi, :formatting, :user, :flash, :form
  engine :etanni
  
  def self.action_missing(path)
    return if path == 'not_found'
    try_resolve('/not_found')
  end
  
  def not_found
    respond! %Q[<html><head><title>404 Not Found</title></head>
    <body><h1>404 Not Found</h1><p>The requested URL <code>#{h(request.REQUEST_URI)}</code>
    was not found on this server</p></body></html>].unindent, 404
  end

end

require_relative 'main'
require_relative 'admin'
