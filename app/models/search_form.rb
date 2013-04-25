class SearchForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name
  #attr_accessor :latitude, :longitude
  #attr_accessor :bedroom_count

	#validates :bedroom_count, :presence => true
  validates :name, :presence => true

	#validate :correct_position

  validate :exists_property_with_that_name,  :unless => lambda { |s| s.name.blank? }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def exists_property_with_that_name
    if Property.where(:name => name).empty?
      errors.add(:base, 'Sorry we cant find that property in our database')      
    end
  end

	#def correct_position
	#	# Validations fails if one of the is filled and the other is not
 	#	if (latitude && longitude.blank?) || (latitude.blank? && longitude)
  #    errors.add(:base, 'Invalid location')      
  #  end
	#end

  def similar
    origin_property = Property.where(:name => name).first
    nearby_properties = Property.within(PROXIMITY_RADIUS, :units => :km, :origin => origin_property)
                                .where("bedroom_count >= ?",origin_property.bedroom_count)
                                .where("name != ?",origin_property.name)
                                .order('distance ASC')
    distance_property_hash = {}
    nearby_properties.each do |property|
      distance_property_hash[origin_property.distance_to(property)] = property
    end
    return distance_property_hash

  end

  def persisted?
    false
  end
end
