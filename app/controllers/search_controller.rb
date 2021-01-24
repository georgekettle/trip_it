class SearchController < ApplicationController
  include MapboxDataFormatter
  skip_before_action :authenticate_user!
  layout 'map_layout'

  def search
    @bbox = set_bbox
    @locations = get_locations
    @posts = get_paginated_results(@locations)
    @features = MapboxDataFormatter.format_features(@posts)
  end

  private

  def set_bbox
    if params[:bbox]
      bbox_arr = params[:bbox].split(/,/).map(&:to_f)
      sw_corner = [bbox_arr[0], bbox_arr[1]]
      ne_corner = [bbox_arr[2], bbox_arr[3]]
      [sw_corner, ne_corner]
    end
  end

  def reverse_bbox_coords
    sw_corner = @bbox[0].reverse
    ne_corner = @bbox[1].reverse
    [sw_corner, ne_corner]
  end

  def get_paginated_results(locations)
    Post.where(location: locations.to_a).sort_by(&:photo_popularity).paginate(page: params[:page], per_page: 20)
  end

  def get_locations
    Location.within_bounding_box(reverse_bbox_coords)
  end
end
