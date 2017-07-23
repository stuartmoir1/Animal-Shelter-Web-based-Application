require 'pry'

require_relative '../db/sql_runner'

class Animal

  attr_reader :id
  attr_accessor :name, :type, :admission_date, :adoptable, :owner_id

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @type = details['type']
    @admission_date = details['admission_date']
    @adoptable = details['adoptable']
    @owner_id = details['owner_id'] # No '.to_i' as may be set to nil.
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

  def owner
    sql = "SELECT * FROM owners WHERE id = $1;"
    values = [@owner_id]
    SqlRunner.run(sql, values)
  end

  ###

  def self.all
    sql = "SELECT * FROM animals ORDER BY id ASC;"
    values = Array.new
    SqlRunner.run(sql, values).map { |animal| Animal.new(animal) }
  end

  def self.find(id)
    sql = "SELECT * FROM animals WHERE id = $1;"
    values = [id]
    animal = SqlRunner.run(sql, values).first
    Animal.new(animal)
  end

  def self.for_adoption
    sql = "SELECT * FROM animals WHERE adoptable = TRUE;"
    values = Array.new
    SqlRunner.run(sql, values).map { |animal| Animal.new(animal) }
  end

  def self.not_for_adoption
    sql = "SELECT * FROM animals WHERE adoptable = FALSE;"
    values = Array.new
    SqlRunner.run(sql, values).map { |animal| Animal.new(animal) }
  end

  def self.types
    sql = "SELECT DISTINCT type FROM animals;"
    values = Array.new
    SqlRunner.run(sql, values)
  end

  def self.by_type(type)
    sql = 'SELECT * FROM animals WHERE type = $1;'
    values = [type]
    SqlRunner.run(sql, values).map { |animal| Animal.new(animal) }
  end

  def self.change_owner(old, new)
    sql = "UPDATE animals SET owner_id = $1 WHERE owner_id = $2;"
    values = [new, old]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM animals WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM animals;"
    values = Array.new
    SqlRunner.run(sql, values)
  end

end