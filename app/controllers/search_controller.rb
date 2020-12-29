class SearchController < ApplicationController
  skip_before_action :authenticate_user!
  def search
    set_coordinates
    @locations = get_locations
    @posts = get_paginated_results(@locations)
    # posts_by_location = @posts.group_by(&:location)
    @features = format_features
    # @locations = posts_by_location.each_with_object({}) { |(k, v), location| location[k.id] = v }
  end

  private

  def get_paginated_results(locations)
    Post.where(location: locations.to_a).sort_by(&:photo_popularity).paginate(page: params[:page], per_page: 20)
  end

  def set_coordinates
    @lng_lat = [ params[:lng].to_f, params[:lat].to_f ]
    @lat_lng = [ params[:lat].to_f, params[:lng].to_f ]
  end

  def get_locations
    radius = 20
    return Location.near(@lat_lng, radius, units: :km)
  end

  # base this on posts (not locations)
  def format_features
    grouped_by_location = @posts.group_by{|post| post.location}
    locations = grouped_by_location.keys
    locations.map do |loc|
      location_hash = loc.attributes
      location_hash[:posts] = grouped_by_location[loc].as_json(include: :photo)

      feature = {
        type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [loc.longitude, loc.latitude]
        },
        properties: location_hash
      }
    end
  end
end
