require 'sequel'

DB = Sequel.postgres(
  :host => 'localhost',
  :user => 'username',
  :password => 'password',
  :database => 'blog',
)

class Sequel::Model
  plugin :timestamps, :update_on_create => true
  plugin :validation_helpers
  plugin :json_serializer
  plugin :xml_serializer
end
