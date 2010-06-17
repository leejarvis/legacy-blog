require 'rake'
require 'rake/clean'

JQUERY_LATEST = "http://code.jquery.com/jquery-latest.js"

CLEAN.include ['*swp', '*~']

namespace :db do
  require_relative 'db/init'
  require_relative 'model/user'
  require_relative 'model/post'

  Sequel.extension :migration

  desc "Migrate database to latest version"
  task :migrate do
    Sequel::Migrator.apply(DB, 'db/migrations')
    puts "Migration complete"
  end

  desc "Drop database to version 0"
  task :drop do
    Sequel::Migrator.apply(DB, 'db/migrations', 0)
    puts "Migrations dropped"
  end

  desc "List users"
  task :users do
    if User.empty?
      puts "No users exist"
    else
      User.each do |user|
        puts "[#{user.created_at.asctime}] #{user.username}"
      end
    end
  end

  desc "List posts"
  task :posts do
    if Post.empty?
      puts "No posts exist"
    else
      Post.each do |post|
        puts "##{post.id} [#{post.created_at.asctime}] by #{post.user.username}"
      end
    end
  end
end

desc "Download the latest jQuery and throw it in /public"
task :jquery do
  require 'open-uri'
  $stdout.sync = true

  File.open("public/jquery.js", 'w') do |f|
    open(JQUERY_LATEST).each_line do |line|
      f.write(line)
      print '.'
    end
  end
  puts " finished"
end

task :default => [:clean]
