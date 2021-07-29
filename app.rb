require 'sinatra'
require 'sinatra/reloader'
require('./lib/cities')
require('./lib/trains')
also_reload 'lib/**/*.rb'
require 'pry'
require "pg"

DB = PG.connect({ dbname: 'train_station', host: 'db', user: 'postgres', password: 'password' })

get('/') do
  redirect to('/station')
end

get('/station') do
  @trains = Train.all
  @cities = City.all
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
  redirect to('/station')
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

get('/cities/new') do
  erb(:new_cities)
end

post('/cities') do
  name = params[:city_name]
  city = City.new({:city_name => name, :id => nil})
  city.save()
  @cities = City.all
  redirect to('/station')
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  @cities = City.all
  erb(:edit_train)
end

post('/trains/:id/edit') do
  @city_name = params[:city_name]
end

