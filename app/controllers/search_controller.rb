class SearchController < ApplicationController
  skip_before_action :authenticate_user!
  def search
    @lng_lat = [ params[:lng].to_f, params[:lat].to_f ]
    @lat_lng = [ params[:lat].to_f, params[:lng].to_f ]
    @radius = 20
    @locations = Location.near(@lat_lng, @radius, units: :km)
    @posts = Post.includes(:locations).where(locations: {id: @locations.to_a.pluck(:id)}).sort_by(&:photo_popularity)
    # @search_query = params[:search]
    # redirect_to root_url
  end
end
