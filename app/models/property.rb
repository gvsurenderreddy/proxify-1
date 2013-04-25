class Property < ActiveRecord::Base
  attr_accessible :bedroom_count, :longitude, :latitude, :name

  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def distance_to property
  	self.distance_from(property, :units=>:kms).round
  end
end
