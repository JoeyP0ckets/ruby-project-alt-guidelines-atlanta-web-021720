class CreateMoviedatabases < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_databases do |t|
      t.string :title
      t.string :genre
      t.string :director
      t.string :year 
    end 
  end
end
