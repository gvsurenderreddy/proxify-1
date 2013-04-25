require "spec_helper"

describe SearchForm do

	it "Form is valid if all fields are filled and the property exists" do
		property = FactoryGirl.create(:property)
		FactoryGirl.build(:search_form, :name => property.name).should be_valid
	end

	it "The property name must be specified" do
		FactoryGirl.build(:search_form, :name => nil).should_not be_valid
	end

	it "Search returns results" do
		property = FactoryGirl.create(:property)
		# 17 Km away
		FactoryGirl.create(:property, 
											 :name => "far away property", 
											 :latitude => "51.672778",
										   :longitude => "-0.023333")


		search_form = FactoryGirl.build(:search_form, :name => property.name)
		assert search_form.similar.any?
	end	


end