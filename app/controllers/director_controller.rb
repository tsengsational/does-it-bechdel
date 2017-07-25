class DirectorController < ApplicationController

  #index
  get '/directors' do
    @directors = Director.all.order(:name)
    erb :'directors/index'
  end

  #create
  get '/directors/new' do
    erb :'directors/new'
  end

  post '/directors' do
    @director = Director.create(params[:director])
    redirect "/directors/#{@director.id}"
  end

  # search
  get '/directors/search' do
    if Director.find_by(name: params[:director][:name])
      @director = Director.find_by(name: params[:director][:name])
      erb :'directors/show'
    else
      redirect '/directors'
    end
  end

  #retrieve
  get '/directors/:id' do
    @director = Director.find(params[:id])
    erb :'directors/show'
  end

  #update
  get '/directors/:id/edit' do
    @director = Director.find(params[:id])
    erb :'directors/edit'
  end

  patch '/directors/:id' do
    @director = Director.find(params[:id])
    @director.update(params[:director])
    redirect "/directors/#{@director.id}"
  end

  #delete
  delete '/directors/:id/delete' do
    @director = Director.find(params[:id])
    @director.destroy
    redirect '/directors'
  end

end
