require 'carrierwave/orm/activerecord'

class Listing < ActiveRecord::Base
	validates :place_name, :place_type, :address, :bedroom, :bath, :amenity, :cost_per_night, :description, presence: true
	mount_uploaders :images, ImageUploader
	belongs_to :user
	belongs_to :address
	has_many :reservations, :dependent => :destroy
end
