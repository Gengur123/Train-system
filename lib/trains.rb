require 'pry'

class Train
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id) 
  end

  def ==(train_to_compare)
    self.name() == train_to_compare.name()
  end  

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id").to_i
    Train.new({:name => name, :id => id})
  end

  def update_by_name(name)
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE train_id = #{@id};") 
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def update(attributes)
    binding.pry
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:stop_name)) && (attributes.fetch(:stop_name) != nil)
      stop_name = attributes.fetch(:stop_name)
      city = DB.exec("SELECT * FROM cities WHERE lower(city_name) ='#{stop_name.downcase}';").first
      if city != nil
        DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{city['id'].to_i}, #{@id});")
      end
    end
  end

  def cities
    cities = []
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{@id};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      city_name = city.first().fetch("city_name")
      cities.push(City.new({:city_name => city_name, :id => city_id}))
    end
    cities
  end

end
