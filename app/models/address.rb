class Address < ActiveRecord::Base
	has_many :listings
	searchkick match: :word_start, searchable: [:jalan, :state, :country]
end
