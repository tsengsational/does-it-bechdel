class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.integer :year
      t.string :title
      t.string :imdb
      t.string :binary
      t.string :detail
      t.integer :director_id
    end
  end
end
