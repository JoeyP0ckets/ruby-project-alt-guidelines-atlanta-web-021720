require_relative '../config/environment'
require "faker"
require_relative "../lib/models/api.rb"

class Runner
    
    @@user = nil
    @@api_caller = API_RUNNER.new()
    @@selected_movie = nil
    
    def self.run_me
        # @@api_caller.check_me
        old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
        startup
        title_screen
        
    end 



#--------greeting-----------
    def self.title_screen
        puts " "
        puts "WELCOME TO FLIM FLAM!!!!"  
        puts "************************"
        puts " "
        puts " "
        puts Faker::Movie.quote  
        puts " "
        puts Faker::Movie.quote
        puts " "
        puts Faker::Movie.quote
        puts " "
        puts "If these quotes mean nothing to you...WATCH MORE MOVIES!!!"
        puts "**********************************************************"
        puts " " 
        puts "Create a Username below to start logging your movies"
        puts " "
        puts "OR"
        puts " "
        puts "Sign in with your Username"
        puts " "
        puts "Please Enter Your Username"
        username = gets.strip
        @@user = create_new_user(username)
        puts " "
        puts " "
        menu
    end 
    
    def self.menu

        keep_going = true
    
        while keep_going == true do 
            puts "1. Enter New Movie"
            puts "2. View All My Favorite Movies"
            puts "3. Search My Movies"
            puts "4. Delete Username"
            puts "5. Exit"
            
            choice = gets.strip.to_i
            if choice == 1 
                # puts "Entering Your New Movie, #{username}"
                enter_new_movie
                keep_going = false
            elsif choice == 2 
                # puts "Viewing All of Your Movies, #{username}"
                view_all_favorite_movies
                keep_going = false
            elsif choice == 3
                # puts "Editing Movies, #{username}"
                search_movie
                keep_going = false
            elsif choice == 4
                # puts "Deleting Username"
                delete_username
                keep_going = false
            elsif choice == 5
               # puts "Exiting"
                exit(0)
                keep_going = false
            else puts "I didn't understand that input."
            end  
        end
         puts "I have now left the loop!"
    end 


#-------------User methods--------------
    def self.create_new_user(username)
        User.find_or_create_by(username: username)
    end 

    def self.delete_username
        puts " "
        puts "Please enter the username you would like to delete."
        username = gets.strip
        user = User.find_by(username: username)
        user.destroy 
        puts "Your Username has been deleted."
        puts " "
        menu
    end 

    def self.delete_movie_by_user
        puts " "
        puts "Please enter the movie title you would like to delete."
        title = gets.strip
        @@user.movie_databases.select do |mov|
            mov.title
        title.destroy
        end 
    end 

# --------Movie methods---------
    def self.enter_new_movie
        puts " "
        puts "Enter Movie Title"
        title = gets.strip
        puts " "
        puts "Enter Movie Genre"
        genre = gets.strip
        puts " "
        puts "Enter Movie Director"
        director = gets.strip
        puts " "
        puts "Enter Movie Year"
        year = gets.strip
        puts "Your New Movie is #{title}, a #{genre} flick, by #{director}, released in #{year}."
        create_new_movie(title, genre, director, year)
    end 
    
    def self.create_new_movie(title, genre, director, year)
        MovieDatabase.find_or_create_by(title: title, genre: genre, director: director, year: year)
        puts " "
        puts "Enter Another Movie? Y/N"
        response = gets.strip
        if response == "Y"
        enter_new_movie
        else
            menu
        end 
    end 
    
        def self.search_movie
        puts "Please insert movie title"
        title = gets.strip
        movie = MovieDatabase.find_by(title: title)
        # @@api_caller.search_by_title(title)
        @@selected_movie = movie
        view_movie_details
    end 
    
    def self.view_movie_details
        puts "Your movie is.."
        puts " "
        puts "#{@@selected_movie.title}, a #{@@selected_movie.genre} film, directed by #{@@selected_movie.director} in #{@@selected_movie.year}."
        # is this movie favorite
        puts " "
        
        if !is_this_movie_favorite()
            puts "Would you like to add this movie to Favorites?"
            answer = gets.strip
            if answer == "Y"
                add_movie_to_favorites
            else 
                menu 
            end 
        else 
            puts "Would you like to remove this movie from Favorites?"
            answer = gets.strip
            if answer == "Y"
                remove_movie_from_favorites
            else
                menu
            end
        end
    end 

# --------Favorites Method---------
    def self.is_this_movie_favorite
        result = FavoriteMovie.find_by(user_id: @@user.id, movie_database_id: @@selected_movie.id)

        if result == nil
            return false
        else 
            return true
        end
    end

    def self.add_movie_to_favorites
            FavoriteMovie.find_or_create_by(user_id: @@user.id, movie_database_id: @@selected_movie.id)
            puts "Your Movie has been added to Favorites"
            puts " "
            menu
        end

    
        def self.remove_movie_from_favorites
        fav_id = FavoriteMovie.find_by(user_id: @@user.id, movie_database_id: @@selected_movie.id).id
        FavoriteMovie.destroy(fav_id)
        puts "#{@@selected_movie.title} has been removed from your favorites!"
        puts " "
        menu
    end

    def self.view_all_favorite_movies
        puts " "
        puts "Here are all your movies."
        fav = FavoriteMovie.where(user_id: @@user.id)   #<-- '.where' returns an array (all results)
        
        fav.each do |mov|
            movie_obj = MovieDatabase.find_by(id: mov.movie_database_id)    #<-- '.find_by' returns one result
            puts "#{movie_obj.title} (#{movie_obj.year})"
        end
        
            puts " "
            puts "Would you like to select a movie? Y/N"
            response = gets.strip
                                    #if Y/N isn't picked make "does not get an input"
            if response == "Y"
                search_movie
            else
                menu
            end 
    end 

    def self.delete_my_movie
        puts " "
        puts "Enter Movie Title you wish to delete"
        title = gets.strip
        movie = MovieDatabase.find_by(title: title)
        movie_to_be_destroyed = FavoriteMovie.find_by(user_id: @@user.id, movie_id: @@selected_movie.id)
        movie_to_be_destroyed.destroy
        puts "#{@@selected_movie} Has Been Deleted."
        menu
    end 
 
    def self.startup
        fgo = MovieDatabase.find_or_create_by(title: "Fargo", genre: "Drama", director: "Cohen Brothers", year: "1996")
        pdt = MovieDatabase.find_or_create_by(title: "The Predator", genre: "Action", director: "John McTiernan", year: "1987")
        alns = MovieDatabase.find_or_create_by(title: "Aliens", genre: "Sci-fi", director: "James Cameron", year: "1986")
        trmtr = MovieDatabase.find_or_create_by(title: "Terminator", genre: "Sci-fi", director: "James Cameron", year: "1984" )
        ersr = MovieDatabase.find_or_create_by(title: "Eraserhead", genre: "Horror", director: "David Lynch", year: "1978")
        dktr = MovieDatabase.find_or_create_by(title: "Dick Tracy", genre: "Noir", director: "Warren Beatty", year: "1988")
    end 
end 

Runner.run_me









