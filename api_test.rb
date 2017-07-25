require_relative './config/environment.rb'

# response = RestClient.get 'http://www.omdbapi.com/?i=tt0065466
# &apikey=ed3ecdff'
#
# parse = JSON.parse(response.body)

movies = Movie.all

movies.each do |movie|
  resp = RestClient.get "http://www.omdbapi.com/?i=#{movie.imdb}&apikey=ed3ecdff"
  # resp = RestClient.get "http://www.omdbapi.com/?i=tt1711425&apikey=ed3ecdff"
  parse = JSON.parse(resp.body)
  if !Director.find_by(name: parse["Director"])
    director = Director.create(name: parse["Director"])
    director.movies << movie
  else
    director = Director.find_by(name: parse["Director"])
    if !director.movies.include?(movie)
      director.movies << movie
    end
  end
  parse["Actors"].split(", ").each do |actor|
    if !Actor.find_by(name: actor)
      new_actor = Actor.create(name: actor)
      new_actor.movies << movie
    else
      new_actor = Actor.find_by(name: actor)
      if !new_actor.movies.include?(movie)
        new_actor.movies << movie
      end
    end
  end
end

# binding.pry
