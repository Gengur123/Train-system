require 'sinatra'
require 'sinatra/reloader'
require('./lib/cities')
require('./lib/trains')
also_reload 'lib/**/*.rb'
require 'pry'
require "pg"

DB = PG.connect({ dbname: 'train_station', host: 'db', user: 'postgres', password: 'password' })

get('/') do
  redirect to('/trains')
end

get('/trains') do
  @trains = Train.all
  erb(:station)
end

get('/trains/new') do
  erb(:new_train)
end

post('/trains') do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all
  redirect to('/trains')
end

