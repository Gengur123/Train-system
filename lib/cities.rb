class City
  attr_reader :id
  attr_accessor :city_name

  def initialize(attributes)
    @city_name = attributes.fetch(:city_name)
    @id = attributes.fetch(:id)
  end

  def ==(city_to_compare)
      self.city_name() == city_to_compare.city_name()
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      city_name = city.fetch("city_name")
      id = city.fetch("id").to_i
      cities.push(City.new({:city_name => city_name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (city_name) VALUES ('#{@city_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    city_name = city.fetch("city_name")
    id = city.fetch("id").to_i
    City.new({:city_name => city_name, :id => id})
  end

  def update_by_name(city_name)
    @city_name = city_name
    DB.exec("UPDATE cities SET city_name = '#{@city_name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM stops WHERE city_id = #{@id};")
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def update(attributes)
    if (attributes.has_key?(:city_name)) && (attributes.fetch(:city_name) != nil)
      @city_name = attributes.fetch(:city_name)
      DB.exec("UPDATE cities SET city_name = '#{@city_name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:train_name)) && (attributes.fetch(:train_name) != nil)
      train_name = attributes.fetch(:train_name)
      train = DB.exec("SELECT * FROM trains WHERE lower(name) ='#{train_name.downcase}';").first
      if train != nil
        DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train['id'].to_i}, #{@id});")
      end
    end
  end

  def trains
    trains = []
    results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{@id};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      trains.push(Train.new({:name => name, :id => train_id}))
    end
    trains
  end
end

