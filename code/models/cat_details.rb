require 'pry'

require_relative '../db/sql_runner'

class CatDetails

  attr_reader :id
  attr_accessor :colour, :live_with_cats, :live_with_dogs, :live_with_family, :indoor_cat, :cat_id

  def initialize(details)
    @id = details['id'].to_i
    @colour = details['colour'] 
    @live_with_cats = details['live_with_cats']
    @live_with_dogs = details['live_with_dogs']
    @live_with_family = details['live_with_family']
    @indoor_cat = details['indoor_cat']
    @cat_id = details['cat_id']
  end

  def save
    sql = "INSERT INTO cat_details (colour, live_with_cats, live_with_dogs, live_with_family, indoor_cat, cat_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id;"
    values = [@colour, @live_with_cats, @live_with_dogs, @live_with_family, @indoor_cat, @cat_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update

    sql = "UPDATE cat_details SET colour = $1, live_with_cats = $2, live_with_dogs = $3, live_with_family = $4, indoor_cat = $5, cat_id = $6 WHERE id = $7;"
    values = [@colour, @live_with_cats, @live_with_dogs, @live_with_family, @indoor_cat, @cat_id, @id]
    SqlRunner.run(sql, values)
  end

  ###

  def self.all
    sql = "SELECT * FROM cat_details;"
    values = Array.new
    SqlRunner.run(sql, values).map { |detail| CatDetails.new(detail) }
  end

end