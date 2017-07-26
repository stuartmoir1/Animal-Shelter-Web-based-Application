require 'pry'

require_relative '../db/sql_runner'

class Animal

  attr_reader :id
  attr_accessor :name, :type, :gender, :age, :breed, :admission_date, :adoptable, :summary, :image_name, :owner_id

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @type = details['type']
    @gender = details['gender']
    @age = details['age'].to_i
    @breed = details['breed']
    @admission_date = details['admission_date']
    @adoptable = details['adoptable']
    @summary = details['summary']
    @image_name = details['image_name']
    @owner_id = details['owner_id'] # No '.to_i' as may be set to nil.
  end

  def save
    sql = "INSERT INTO animals (name, type, gender, age, breed, admission_date, adoptable, summary, image_name, owner_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id;"
    values = [@name, @type, @gender, @age, @breed, @admission_date, @adoptable, @summary, @image_name, @owner_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update
    sql = "UPDATE animals SET name = $1, type = $2, gender = $3, age = $4, breed = $5, admission_date = $6, adoptable = $7, summary = $8, image_name = $9, owner_id = $10 WHERE id = $11;"
    values = [@name, @type, @gender, @age, @breed, @admission_date, @adoptable, @summary, @image_name, @owner_id, @id]
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
    sql = "SELECT * FROM animals WHERE adoptable = TRUE AND owner_id = 1;"
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