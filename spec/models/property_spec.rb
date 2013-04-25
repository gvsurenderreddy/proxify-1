require "spec_helper"

describe Property do

	it "Creates a valid property" do
		FactoryGirl.build(:property).should be_valid
	end

	it "Calculates the distante to another property" do
		far_away_property = FactoryGirl.create(:property, 
																					 :name => "far away property", 
																					 :latitude => "52.523778",
																					 :longitude => "-0.023333")

		origin_property = FactoryGirl.create(:property) 
		origin_property.distance_to(far_away_property).should eq(111)
  end

end