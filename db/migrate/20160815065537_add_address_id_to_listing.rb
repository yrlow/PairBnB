class AddAddressIdToListing < ActiveRecord::Migration
  def change
    add_column :listings, :address_id, :integer
  end
end
