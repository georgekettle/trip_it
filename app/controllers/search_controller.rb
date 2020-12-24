class SearchController < ApplicationController
  skip_before_action :authenticate_user!
  def search
    @search_query = params[:search]
    # redirect_to root_url
  end
end
