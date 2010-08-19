require 'digest/sha1'

class User < Sequel::Model
  one_to_many :posts

  def self.sha1(str=nil)
    Digest::SHA1.hexdigest(str || "")
  end

  def self.add(username, password)
    create username: username, password: sha1(password)
  end

  def self.authenticate(creds)
    User[username: creds["username"], password: sha1(creds["password"])]
  end
end
