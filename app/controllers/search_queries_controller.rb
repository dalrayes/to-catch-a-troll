class SearchQueriesController < ApplicationController

  before_action :authenticate_user!

  before_action :all_queries, only: [:index, :create]
  respond_to :html, :js

  def new
    @search_query = SearchQuery.new
  end

  def edit
   @search_query = SearchQuery.find_by(id: params[:id])
  end

  def update
    @search_query = SearchQuery.find_by(id: params[:id])
    @search_query.update_attributes(search_query_params)
    redirect_to home_path
  end

  def create
    @search_query = SearchQuery.create(user: current_user)
    @search_query.update_attributes(search_query_params)

    redirect_to home_path
  end


  private

  def all_queries
    @search_queries = SearchQuery.find_by(user_id: current_user.id)
  end

  def search_query_params
    params.require(:search_query).permit(:first_name, :last_name, :address, :zipcode, :phone_number)
  end

end
