class SearchFormController < ApplicationController
  def index
  	@search_form = SearchForm.new
  end

  def create
  	@search_form = SearchForm.new(params[:search_form])
  	if @search_form.valid? 
  		@similar_properties = @search_form.similar
  	else
  		@errors = @search_form.errors.full_messages
  	end
  	render :index  	
  end
end
