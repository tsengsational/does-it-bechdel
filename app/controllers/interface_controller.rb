class InterfaceController < ApplicationController

  # index
  get '/' do
    erb :'interfaces/index'
  end

  get '/movie' do
    if @movie = Movie.find_by(title: params[:movie][:title])
      resp = RestClient.get "http://www.omdbapi.com/?t=#{params[:movie][:title]}&apikey=ed3ecdff"
      parse = JSON.parse(resp.body)
      @poster = parse["Poster"]
      erb :'interfaces/movie'
    else
      redirect :'/'
    end
    # binding.pry
  end

  get '/actor' do
    if @actor = Actor.find_by(name: params[:actor][:name])
      erb :'interfaces/actor'
    end
  end

  get '/director' do
    if @director = Director.find_by(name: params[:director][:name])
      erb :'interfaces/director'
    end
  end

  get '/index2' do
    erb :'interfaces/index2'
  end


end
