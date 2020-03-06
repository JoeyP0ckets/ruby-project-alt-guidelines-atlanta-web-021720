class FavoriteMovie < ActiveRecord::Base
    belongs_to :user
    belongs_to :movie_database
end 