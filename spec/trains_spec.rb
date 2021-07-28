require('spec_helper')

describe '#Train' do

  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an train") do
      train = Train.new({:name => "Blue Line", :id => nil})
      train.save()
      train2 = Train.new({:name => "Red Line", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      train = Train.new({:name => "Thomas", :id => nil})
      train.save()
      train2 = Train.new({:name => "Percy", :id => nil})
      train2.save()
      Train.clear
      expect(Train.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({:name => "Percy", :id => nil})
      train2 = Train.new({:name => "Percy", :id => nil})
      expect(train).to(eq(train2))
    end
  end

  describe('.find') do
    it("finds an train by id") do
      train = Train.new({:name => "Percy", :id => nil})
      train.save()
      train2 = Train.new({:name => "Thomas", :id => nil})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('#update_by_name') do
    it("updates an train by id") do
      train = Train.new({:name => "Thomas", :id => nil})
      train.save()
      train.update_by_name("Percy")
      expect(train.name).to(eq("Percy"))
    end
  end

  describe('#delete') do
    it("deletes all trains belonging to a deleted train") do
      train = Train.new({:name => "Percy", :id => nil})
      train.save()
      train2 = Train.new({:name => "Thomas", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('#update') do
  it("adds a city to a train") do
    city = City.new({:city_name => "Portland",:id => nil})
    city.save()
    city2 = City.new({:city_name => "Vancouver",:id => nil})
    city2.save()
    train = Train.new({:name => "Percy", :id => nil})
    train.save()
    train.update({:stop_name => "Portland"})
    binding.pry
    expect(train.cities).to(eq([city]))
  end
end


end