class SearchController < ApplicationController
  include MapboxDataFormatter
  skip_before_action :authenticate_user!
  layout 'map_layout'

  def search
    @locations = get_locations
    @posts = get_paginated_results(@locations)
    @features = MapboxDataFormatter.format_features(@posts)
    @bbox = set_bbox
  end

  private

  def set_bbox
    if params[:bbox]
      bbox_arr = params[:bbox].split(/,/).map(&:to_f)
      return [
        [bbox_arr[0], bbox_arr[1]],
        [bbox_arr[2], bbox_arr[3]]
      ]
    else
      return MapboxDataFormatter.set_bbox(@features, @lng_lat)
    end
  end

  def get_paginated_results(locations)
    Post.where(location: locations.to_a).sort_by(&:photo_popularity).paginate(page: params[:page], per_page: 5)
  end

  def get_locations
    radius = 50
    @lng_lat = [ params[:lng].to_f, params[:lat].to_f ]
    @lat_lng = [ params[:lat].to_f, params[:lng].to_f ]
    return Location.near(@lat_lng, radius, units: :km)
  end
end
