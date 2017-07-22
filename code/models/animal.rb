require_relative '../db/sql_runner'

class Animal

  attr_writer :name, :type, :admission_date, :adoptable, :owner_id

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @type = details['type']
    @admission_date = details['admission_date']
    @adoptable = details['adoptable']
    @owner_id = details['owner_id']
  end

  def save
    sql = "INSERT INTO animals (name, type, admission_date, adoptable, owner_id) VALUES ($1, $2, $3, $4, $5) RETURNING id;"
    values = [@name, @type, @admission_date, @adoptable, @owner_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update
    sql = "UPDATE animals SET name = $1, type = $2, admission_date = $3, adoptable = $4, owner_id = $5 WHERE id = $6;"
    values = [@name, @type, @admission_date, @adoptable, @owner_id, @id]
    SqlRunner.run(sql, values)
  end

  ###

  def self.all
    sql = "SELECT * FROM animals"
    values = Array.new
    SqlRunner.run(sql, values).map { |animal| Animal.new(animal) }
  end

  # def self.find(id)
  #   sql = "SELECT * FROM animals WHERE id = $1"
  #   values = [@id]
  #   animal = SqlRunner.run(sql, values).first
  #   Animal.new(animal)
  # end

  def self.delete_all
    sql = "DELETE FROM animals;"
    values = Array.new
    SqlRunner.run(sql, values)
  end

end