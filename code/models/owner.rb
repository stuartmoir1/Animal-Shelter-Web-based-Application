require 'pry'

require_relative '../db/sql_runner'

class Owner

  attr_reader :id
  attr_accessor :name

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
  end

  def save
    sql = "INSERT INTO owners (name) VALUES ($1) RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update
   sql = "UPDATE owners SET name = $1 WHERE id = $2;"
   values = [@name, @id]
   SqlRunner.run(sql, values)
  end

  def animals
    sql = "SELECT * FROM animals WHERE owner_id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  ###

  def self.all
    sql = "SELECT * FROM owners ORDER BY id ASC;"
    values = Array.new
    SqlRunner.run(sql, values).map { |owner| Owner.new(owner) }
  end

  def self.owner(id)
    sql = "SELECT * from owners WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values).each { |i| i }
  end

  def self.find(id)
    sql = "SELECT * FROM owners WHERE id = $1;"
    values = [id]
    owner = SqlRunner.run(sql, values).first
    Owner.new(owner)
  end

  def self.delete(id)
    sql = "DELETE FROM owners WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM owners WHERE id <> 1;"
    values = Array.new
    SqlRunner.run(sql, values)
  end

end