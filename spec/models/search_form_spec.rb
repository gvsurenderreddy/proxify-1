require "spec_helper"

describe SearchForm do

	it "Form is valid if all fields are filled and the property exists" do
		property = FactoryGirl.create(:property)
		FactoryGirl.build(:search_form, :name => property.name).should be_valid
	end

	it "The property name must be specified" do
		FactoryGirl.build(:search_form, :name => nil).should_not be_valid
	end

	context "Properties with " do

		it "20km radius and same bedroom are returned" do
			# 17 Km away
			FactoryGirl.create(:property, :name => "nearby property", :latitude => "51.672778", :longitude => "-0.023333")

			property = FactoryGirl.create(:property)
			search_form = FactoryGirl.build(:search_form, :name => property.name)

			assert search_form.similar.any?
		end	

		it "bedroom count below the desired property are not included" do
			property = FactoryGirl.create(:property)
			# 17 Km away
			FactoryGirl.create(:property, :name => "short rooms property", :latitude => "51.672778", :longitude => "-0.023333", :bedroom_count => property.bedroom_count-1)
			
			search_form = FactoryGirl.build(:search_form, :name => property.name)

			assert search_form.similar.empty?
		end		

		it "distance above 20km are not considered" do
			property = FactoryGirl.create(:property)

			FactoryGirl.create(:property, :name => "far away property", :latitude => "52.672778", :longitude => "-0.023333", :bedroom_count => property.bedroom_count-1)
			
			search_form = FactoryGirl.build(:search_form, :name => property.name)

			assert search_form.similar.empty?
		end			
	end

		it "the current property is not included in the results" do
			property = FactoryGirl.create(:property)
			search_form = FactoryGirl.build(:search_form, :name => property.name)

			assert search_form.similar.empty?
		end	

	


end