require 'rspec'
require 'pg'
require 'pry'
require 'trains'
require 'cities'

DB = PG.connect({ dbname: 'train_station_test', host: 'db', user: 'postgres', password: 'password' })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM stops *;")
  end
end
