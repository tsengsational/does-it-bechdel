class ActorController < ApplicationController

    #index
    get '/actors' do
      @actors = Actor.all.order(:name)
      erb :'actors/index'
    end

    #create
    get '/actors/new' do
      erb :'actors/new'
    end

    post '/actors' do
      @actor = Actor.create(params[:actor])
      redirect "/actors/#{@actor.id}"
    end

    # search
    get '/actors/search' do
      if Actor.find_by(name: params[:actor][:name])
        @actor = Actor.find_by(name: params[:actor][:name])
        erb :'actors/show'
      else
        redirect :'/actors'
      end
    end

    #retrieve
    get '/actors/:id' do
      @actor = Actor.find(params[:id])
      erb :'actors/show'
    end


    #update
    get '/actors/:id/edit' do
      @actor = Actor.find(params[:id])
      erb :'actors/edit'
    end

    patch '/actors/:id' do
      @actor = Actor.find(params[:id])
      @actor.update(params[:actor])
      redirect "/actors/#{@actor.id}"
    end

    #delete
    delete '/actors/:id/delete' do
      @actor = Actor.find(params[:id])
      @actor.destroy
      redirect '/actors'
    end

end
