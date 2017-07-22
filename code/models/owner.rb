require 'pry'

require_relative '../db/sql_runner'

class Owner

  def initialize(details)
    @id = details['id']
    @name = details['name']
  end

  def save
    sql = "INSERT INTO owners (name) VALUES ($1) RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def animals
    sql = "SELECT * FROM animals WHERE owner_id = $1"
    values = [@id]
    @id = SqlRunner.run(sql, values)
  end

  ###

  def self.all
    sql = "SELECT * FROM owners"
    values = Array.new
    SqlRunner.run(sql, values).map { |owner| Owner.new(owner) }
  end

end