class SearchController < ApplicationController
  skip_before_action :authenticate_user!
  def search
    @lng_lat = [ params[:lng].to_f, params[:lat].to_f ]
    @lat_lng = [ params[:lat].to_f, params[:lng].to_f ]
    @radius = 20
    locations_near = Location.near(@lat_lng, @radius, units: :km)
    @posts = Post.where(location: locations_near.to_a).sort_by(&:photo_popularity).first(20)
    locations = @posts.group_by(&:location)
    @locations = locations.each_with_object({}) { |(k, v), location| location[k.attributes] = v }
  end
end
