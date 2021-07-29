require 'rspec'
require 'pry'
require 'spec_helper'

describe '#Class' do

  before(:each) do
    @train = Train.new({:name => "Thomas", :id => nil})
    @train.save()
    end


  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city = City.new({:city_name => "Portland", :id => nil})
      city2 = City.new({:city_name => "Portland", :id => nil})
      expect(city).to(eq(city2))
    end
  end

  describe('.all') do
    it("returns a list of all cities") do
      city = City.new({:city_name => "Portland",:id => nil})
      city.save()
      city2 = City.new({:city_name => "Vancouver", :id => nil})
      city2.save()
      expect(City.all).to(eq([city, city2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new({:city_name => "Portland",:id => nil})
      city.save()
      city2 = City.new({:city_name => "Vancouver", :id => nil})
      city2.save()
      City.clear()
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a city") do
      city = City.new({:city_name => "Portland",:id => nil})
      city.save()
      expect(City.all).to(eq([city]))
    end
  end

  describe('.find') do
    it("finds a city by id") do
      city = City.new({:city_name => "Portland",:id => nil})
      city.save()
      city2 = City.new({:city_name => "Vancouver", :id => nil})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end


#   describe('#update') do
#   it("adds an train to a city") do
#     city = City.new({:city_name => "Portland",:id => nil})
#     city.save()
#     train = Train.new({:name => "Percy", :id => nil})
#     train.save()
#     city.update({:train_name => "Percy"})
#     expect(city.trains).to(eq([train]))
#   end
# end

describe('#update') do
    it("updates an album by id") do
      city = City.new({:city_name => "Portland",:id => nil})
      city.save()
      city.update_by_name("Salem")
      expect(city.city_name).to(eq("Salem"))
    end
  end

  describe('#delete') do
    it("deletes a city by id") do
      city = City.new({:city_name => "Portland",:id => nil})
      city.save()
      city2 = City.new({:city_name => "Vancouver", :id => nil})
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end
end

