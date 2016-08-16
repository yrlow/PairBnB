class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :place_name
      t.string :place_type
      t.string :address
      t.string :bedroom
      t.string :bath
      t.string :amenity
      t.string :cost_per_night
      t.string :description

      t.timestamps null: false
    end
  end
end
