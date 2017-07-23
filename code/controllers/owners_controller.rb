require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/animal'
require_relative '../models/owner'

get '/owners' do
  @owners = Owner.all
  erb(:"owners/index")
end

get '/owners/new' do
  @owners= Owner.all
  erb(:"owners/new")
end

get '/owners/:id/edit' do
  @owner = Owner.find(params[:id])
  erb(:"owners/edit")
end

post '/owners/save' do
  owner = Owner.new(params)
  owner.save
  redirect to('/owners')
end

post '/owners/:id/update' do
  owner = Owner.new(params)
  owner.update
  redirect to('/owners')
end

post '/owners/:id/delete' do
  Owner.delete(params[:id])
  redirect to("/owners")
end

post '/owners/delete_all' do
  Owner.delete_all
  redirect to("/owners")
end