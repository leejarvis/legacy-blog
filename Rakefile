namespace :db do
  require_relative 'model/init'

  Sequel.extension :migration

  desc "Migrate database to latest version"
  task :migrate do
    Sequel::Migrator.apply(DB, 'migrations')
    puts "Migration complete"
  end

  desc "Drop database to version 0"
  task :drop do
    Sequel::Migrator.apply(DB, 'migrations', 0)
    puts "Migrations dropped"
  end
end
