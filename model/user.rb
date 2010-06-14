require 'digest/sha1'

class User < Sequel::Model
  one_to_many :posts

  def self.add(username, password)
    create(:username => username, :password => Digest::SHA1.hexdigest(password))
  end

  def self.authenticate(user, pass)
    User[:username => user, :password => Digest::SHA1.hexdigest(pass)]
  end
end
