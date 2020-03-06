fgo = MovieDatabase.find_or_create_by(title: "Fargo", genre: "Drama", director: "Cohen Brothers", year: "1996")
pdt = MovieDatabase.find_or_create_by(title: "The Predator", genre: "Action", director: "John McTiernan", year: "1987")
alns = MovieDatabase.find_or_create_by(title: "Aliens", genre: "Sci-fi", director: "James Cameron", year: "1986")
trmtr = MovieDatabase.find_or_create_by(title: "Terminator", genre: "Sci-fi", director: "James Cameron", year: "1984" )
ersr = MovieDatabase.find_or_create_by(title: "Eraserhead", genre: "Horror", director: "David Lynch", year: "1978")
dktr = MovieDatabase.find_or_create_by(title: "Dick Tracy", genre: "Noir", director: "Warren Beatty", year: "1988")

user_captainhowdy = User.find_or_create_by(username: "CaptainHowdy")
user_imfilmbuff = User.find_or_create_by(username: "I'm(film)Buff")
user_ripripley = User.find_or_create_by(username: "RIP-Ripley")
user_magnificent = User.find_or_create_by(username: "Magnficent 69")
user_everyframe = User.find_or_create_by(username: "Everyframeapic")

FavoriteMovie.find_or_create_by(user_id: user_captainhowdy.id, movie_database_id: fgo.id)
FavoriteMovie.find_or_create_by(user_id: user_imfilmbuff.id, movie_database_id: pdt.id)
FavoriteMovie.find_or_create_by(user_id: user_ripripley.id, movie_database_id: alns.id)
FavoriteMovie.find_or_create_by(user_id: user_magnificent.id, movie_database_id: trmtr.id)
FavoriteMovie.find_or_create_by(user_id: user_ripripley.id, movie_database_id: ersr.id)
FavoriteMovie.find_or_create_by(user_id: user_everyframe.id, movie_database_id: dktr.id)