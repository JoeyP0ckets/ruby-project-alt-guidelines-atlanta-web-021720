class User < ActiveRecord::Base
has_many :favorite_movies
has_many :movie_databases, through: :favorite_movies
end 