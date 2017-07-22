require_relative '../db/sql_runner'

class Animal

  def initialize(details)
    @id = details['id']
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
    sql = "UPDATE animals SET name = '#{@name}', type = '#{@type}', admission_date = '#{@admission_date}', adoptable = #{@adoptable}, owner_id = #{@owner_id} WHERE id = #{@id};"
    values = [@name, @type, @admission_date, @adoptable, @owner_id]
    SqlRunner.run(sql, values)
  end

  ###

  def self.all
   sql = "SELECT * FROM animals"
   values = Array.new
   SqlRunner.run(sql, values).map { |animal| Animal.new(animal) }
  end

end