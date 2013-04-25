FactoryGirl.define do

	factory :property do		
    name 'room 1'
    bedroom_count 3
    latitude "51.523778"
    longitude "-0.013333"
  end
  
  factory :search_form do 
  	name 'some room'
  end

end