require 'unirest'
require 'json'

class API_RUNNER

    @@api_url_base = "https://movie-database-imdb-alternative.p.rapidapi.com/"
    @@api_search_by_title_template = "?page=1&r=json&s="

    def initialize

    end 

    def movie_by_title
        
    end 
    


    def check_me
        response = Unirest.get "#{@@api_url_base}?page=1&r=json&s=Blade+Runner+2049",
        headers:{
            "X-RapidAPI-Host" => "movie-database-imdb-alternative.p.rapidapi.com",
            "X-RapidAPI-Key" => "ea4deba157msh20974ba3dd19506p11f45djsna288c2eedde7"
        }
        
        
        search_json = JSON.parse(response.raw_body)["Search"]
        id = search_json[0]['imdbID']

        response = Unirest.get "#{@@api_url_base}?page=1&r=json&i=#{id}",
        headers:{
            "X-RapidAPI-Host" => "movie-database-imdb-alternative.p.rapidapi.com",
            "X-RapidAPI-Key" => "ea4deba157msh20974ba3dd19506p11f45djsna288c2eedde7"
        }
        full_json = JSON.parse(response.raw_body)
        puts "#{full_json["Title"]} released in #{full_json["Year"]} directed by #{full_json["Director"]} is a #{full_json["Genre"]} movie"
        # puts search_json[0]["imdbID"]
    end 

    def search_by_title(title)
        response = Unirest.get "#{@@api_url_base}?page=1&r=json&s=#{title}",
        headers:{
            "X-RapidAPI-Host" => "movie-database-imdb-alternative.p.rapidapi.com",
            "X-RapidAPI-Key" => "ea4deba157msh20974ba3dd19506p11f45djsna288c2eedde7"
        }
        
        
        search_json = JSON.parse(response.raw_body)["Search"]
        puts "#{search_json[0]["Title"]} released in #{search_json[0]["Year"]}"
    end 

    def call_api(url)
    
    end 

    def parse_response_into_movie_object
        full_json = JSON.parse(response.raw_body)
    end 



end 