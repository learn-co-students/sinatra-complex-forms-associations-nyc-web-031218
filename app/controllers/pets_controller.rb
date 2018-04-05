class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(name: params[:pet][:name])

    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet.owner = owner
    else
      owner_id = params[:pet][:owner_id][0]
      @pet.owner_id = owner_id
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"pets/edit"
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])

    @pet.name = params[:pet][:name]

    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet.owner = owner
    else
      owner_id = params[:pet][:owner_id][0]
      @pet.owner_id = owner_id
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
