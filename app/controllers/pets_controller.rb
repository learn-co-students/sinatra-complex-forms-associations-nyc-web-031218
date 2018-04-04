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
    @pet = Pet.create(name: params[:pet_name])
    if !params[:owner_name].empty?
    @pet.owner = Owner.create(name: params[:owner_name])
    else
     @pet.owner = Owner.find(params[:owner_id])
  end
  @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    owner1 = @pet.owner
    if params[:owner][:name]
      @pet.owner = Owner.find(params[:owner][:name])
   end
   if owner1 == @pet.owner
     @pet.owner = Owner.create(name: params[:owner_name])
  end
  @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
