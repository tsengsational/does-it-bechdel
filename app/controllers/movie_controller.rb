class MovieController < ApplicationController

  #index
  get '/movies' do
    @movies = Movie.all.order(:title)
    erb :'movies/index'
  end

  #create
  get '/movies/new' do
    @actors = Actor.all.order(:name)
    @directors = Director.all.order(:name)
    erb :'movies/new'
  end

  get '/movies/new_api' do
    @actors = Actor.all.order(:name)
    @directors = Director.all.order(:name)
    erb :'movies/new_api'
  end

  post '/movies' do
    @movie = Movie.create(params[:movie])
    # @director = Director.find_by(name:)
    redirect "/movies/#{@movie.id}"
  end

  post '/movies/api' do
    resp = RestClient.get "http://www.omdbapi.com/?t=#{params[:movie][:title]}&apikey=ed3ecdff"
    parse = JSON.parse(resp.body)
    if parse["Error"] == "Movie not found!"
      redirect '/movies/new_api'
    else
      if Movie.find_by(title: params[:movie][:title])
        @movie = Movie.find_by(title: params[:movie][:title])
        @movie.update(binary: params[:movie][:binary], detail: params[:movie][:detail], year: parse["Year"], imdb: parse["imdbID"])
        if !Director.find_by(name: parse["Director"])
          @director = Director.create(name: parse["Director"])
          @director.movies << @movie
        else
          @director = Director.find_by(name: parse["Director"])
          if !@director.movies.include?(@movie)
            @director.movies << @movie
          end
        end
        parse["Actors"].split(", ").each do |actor|
          if !Actor.find_by(name: actor)
            @actor = Actor.create(name: actor)
            @actor.movies << @movie
          else
            @actor = Actor.find_by(name: actor)
            if !@actor.movies.include?(@movie)
              @actor.movies << @movie
            end
          end
        end
      else
        @movie = Movie.create(year: parse["Year"], title: parse["Title"], imdb: parse["imdbID"], binary: params[:movie][:binary], detail: params[:movie][:detail])
        if !Director.find_by(name: parse["Director"])
          @director = Director.create(name: parse["Director"])
          @director.movies << @movie
        else
          @director = Director.find_by(name: parse["Director"])
          if !@director.movies.include?(@movie)
            @director.movies << @movie
          end
        end
        parse["Actors"].split(", ").each do |actor|
          if !Actor.find_by(name: actor)
            @actor = Actor.create(name: actor)
            @actor.movies << @movie
          else
            @actor = Actor.find_by(name: actor)
            if !@actor.movies.include?(@movie)
              @actor.movies << @movie
            end
          end
        end
      end
    end
    redirect "/movies/#{@movie.id}"
  end

  # search
  get 'movies/search' do
    if Movie.find_by(title: params[:movie][:title])
      @actor = Movie.find_by(title: params[:movie][:title])
      erb :'movies/show'
    else
      redirect :'/movies'
    end
  end

  #retrieve
  get '/movies/:id' do
    @movie = Movie.find(params[:id])
    erb :'movies/show'
  end

  #update
  get '/movies/:id/edit' do
    @movie = Movie.find(params[:id])
    @actors = Actor.all.order(:name)
    @directors = Director.all.order(:name)
    erb :'movies/edit'
  end

  patch '/movies/:id' do
    @movie = Movie.find(params[:id])
    @movie.update(params[:movie])
    redirect "/movies/#{params[:id]}"
  end

  #delete
  delete '/movies/:id/delete' do
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect '/movies'
  end

end
