class Cities  
  attr_reader :id
  attr_accessor :name, :city_id

  def initialize(attributes)
    @city_name = attributes.fetch(:city_name)
    @train_id = attributes.fetch(:train_id)
    @id = attributes.fetch(:id)
  end

  def ==(city_to_compare)
    if city_to_compare != nil
      (self.city_name() == city_to_compare.city_name()) && (self.train_id() == city_to_compare.train_id())
    else
      false
    end
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      city_name = city.fetch("city_name")
      train_id = train.fetch("train_id").to_i
      id = city.fetch("id").to_i
      cities.push(City.new({:city_name => city_name, :train_id => train_id, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (city_name, train_id) VALUES ('#{@city}', #{@train_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    if city
    city_name = city.fetch("city_name")
    train_id = city.fetch("train_id").to_i
    id = city.fetch("id").to_i
    City.new({:city_name => city_name, :train_id => train_id, :id => id})
    else
      nil
    end
  end

  def update(city_name, train_id)
    @city_name = city_name
    @train_id = train_id
    DB.exec("UPDATE cities SET city_name = '#{@city_name}', train_id = #{@train_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find_by_train(trn_id)
    cities = []
    returned_cities = DB.exec("SELECT * FROM cities WHERE train_id = #{trn_id};")
    returned_cities.each() do |city|
      name = city.fetch("city_name")
      id = city.fetch("id").to_i
      cities.push(City.new({:city_name => city_name, :train_id => trn_id, :id => id}))
    end
    cities
  end

  def train
    Train.find(@train_id)
  end
end

