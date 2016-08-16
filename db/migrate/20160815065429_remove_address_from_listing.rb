class RemoveAddressFromListing < ActiveRecord::Migration
  def change
    remove_column :listings, :address, :string
  end
end
