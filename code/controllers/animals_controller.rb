require 'sinatra'
require 'sinatra/contrib/all'

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
  @owners = Owner.all
  @heading = 'For Adoption'
  erb(:"animals/index")
end

# List details of animals not for adoption only.
get '/animals/not_for_adoption' do
  @animals = Animal.not_for_adoption
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
  @owners = Owner.all
  @heading = params[:type].capitalize + 's'
  erb(:"animals/index")
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
  animal = Animal.new(params[:name, :type, :gender, :age, :breed, :admission_date, :adoptable, :summary, :owner_id])
  cat_details = CatDetails.new(params[:colour, :live_with_cats, :live_with_dogs, :live_with_family, :indoor_cat])
  animal.save
  cat_details.save
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

# Delete details or all animals from DB.
post '/animals/delete_all' do
  Animal.delete_all
  redirect to("/animals")
end
