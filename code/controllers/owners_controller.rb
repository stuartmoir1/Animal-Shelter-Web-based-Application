require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/animal'
require_relative '../models/owner'

# List details of all owners.
get '/owners' do
  @owners = Owner.all
  @animals = Animal.all
  erb(:"owners/index")
end

# Create new owner.
get '/owners/new' do
  @owners = Owner.all
  erb(:"owners/new")
end

# List details of owner.
get '/owners/:id' do
  @owner = Owner.find(params[:id])
  @animals = Animal.all
  erb(:"owners/show")
end

# Edit details of owner.
get '/owners/:id/edit' do
  @owner = Owner.find(params[:id])
  erb(:"owners/edit")
end

###

# Save details of owners to DB.
post '/owners/save' do
  owner = Owner.new(params)
  owner.save
  redirect to('/owners')
end

# Update details of onwers to DB.
post '/owners/:id/update' do
  owner = Owner.new(params)
  owner.update
  redirect to('/owners')
end

# Delete details of owner from DB.
post '/owners/:id/delete' do
  Owner.delete(params[:id])
  redirect to("/owners")
end

# Delete details of all owners from DB.
post '/owners/delete_all' do
  Owner.delete_all
  redirect to("/owners")
end