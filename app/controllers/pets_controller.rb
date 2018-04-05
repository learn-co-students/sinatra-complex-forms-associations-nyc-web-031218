require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    if !params[:owner_name].empty?
      @pet.owner_id = Owner.create(name: params[:owner_name]).id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"pets/edit"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    # binding.pry
    @pet.name = params[:pet][:name]
    @pet.owner_id = params[:pet][:owner_id].to_i
    # binding.pry
    if !params[:owner][:name].empty?
      # binding.pry
      @pet.owner_id = Owner.create(name: params[:owner][:name]).id
    end
     @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
