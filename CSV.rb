require 'csv'
require_relative './config/environment.rb'

movies = {}


# CSV_FILE_PATH = File.join(File.dirname(__FILE__), "movies.csv")
#
# CSV.foreach(CSV_FILE_PATH, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
#   movies
# end

# data = CSV.read("movies.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

hashed_data = data.map { |d| d.to_hash }
Movie.bulk_insert do |movie|
  hashed_data.each do |row|
    movie.add(year: row[:year], title: row[:title], imdb: row[:imdb], binary: row[:binary], detail: row[:clean_test])
  end
end


# puts hashed_data[1]
