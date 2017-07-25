class Actor < ActiveRecord::Base
  has_many :actor_movies
  has_many :movies, through: :actor_movies
end
