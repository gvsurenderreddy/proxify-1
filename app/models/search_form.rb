class SearchForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name

  validates :name, :presence => true

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
