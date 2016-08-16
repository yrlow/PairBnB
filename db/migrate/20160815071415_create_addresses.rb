class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :jalan
      t.string :state
      t.string :country
    end
  end
end
