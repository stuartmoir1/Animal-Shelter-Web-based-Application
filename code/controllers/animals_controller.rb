require 'sinatra'
require 'sinatra/contrib/all'
require 'pry'

require_relative '../models/animal'
require_relative '../models/owner'
require_relative '../models/cat_details'

# List details of animals.
get '/animals' do
  @animals = Animal.all
  @cat_details = CatDetails.all
  @owners = Owner.all
  @heading = 'Animals'
  erb(:"animals/index")
end

# Create new animal.
get '/animals/new' do
  @type = params[:type]
  @owners= Owner.all
  erb(:"animals/new")
end

# List details of animals for adoption only.
get '/animals/for_adoption' do
  @animals = Animal.for_adoption
  @cat_details= CatDetails.all
  @owners = Owner.all
  @heading = 'For Adoption'
  erb(:"animals/index")
end

# List details of animals not for adoption only.
get '/animals/not_for_adoption' do
  @animals = Animal.not_for_adoption
  @cat_details = CatDetails.all
  @owners = Owner.all
  @heading = 'Not For Adoption'
  erb(:"animals/index")
end

# Input animal type to search.
get '/animals/search_by_type' do
  erb(:"animals/search_by_type")
end

# Input animal type to add.
get '/animals/add_by_type' do
  @types = Animal.types
  erb(:"animals/add_by_type")
end

# List details of animals by type.
get '/animals/display_by_type' do
  @animals = Animal.by_type(params[:type])
  @cat_details = CatDetails.all
  @owners = Owner.all
  @heading = params[:type].capitalize + 's'
  erb(:"animals/index")
end

get '/animals/image' do
  erb (:"animals/image")
end

# List details of animal.
get '/animals/:id' do
  @animal = Animal.find(params[:id])
  @cat_details = CatDetails.all
  @owners = Owner.all
  erb(:"animals/show")
end

# Edit details of animal.
get '/animals/:id/edit' do
  @animal = Animal.find(params[:id])
  @cat_details = CatDetails.all
  @owners= Owner.all
  erb(:"animals/edit")
end

###

# Save details of animals to DB.
post '/animals/save' do

  binding.pry

  # Save image file to folder.
  if params[:image][:filename] != nil
    filename = params[:image][:filename]
    tempfile = params[:image][:tempfile]
    File.open("./public/images/#{filename}", 'wb') do |file|
      file.write(tempfile.read)
    end
  end

  animal = Animal.new(params)
  cat_details = CatDetails.new(params)
  animal.save
  if animal.type == 'cat'
    cat_details.cat_id = animal.id
    cat_details.save
  end
  redirect to('/animals')
end

# Update details of animal to DB.
post '/animals/:id/update' do
  animal = Animal.new(params)
  # Allow for conflicting adoptable/ owner input values. Value of owner
  # takes priority.
  animal.owner_id != 1 ? animal.adoptable = true : animal.adoptable = false
  animal.update
  redirect to('/animals')
end

# Delete details of animal from DB.
post '/animals/:id/delete' do
  Animal.delete(params[:id])
  redirect to("/animals")
end

# Delete details of all animals from DB.
post '/animals/delete_all' do
  Animal.delete_all
  redirect to("/animals")
end
