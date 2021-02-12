module MapboxDataFormatter
  # base this on posts (not locations)
  def self.format_features(posts)
    grouped_by_location = posts.group_by{|post| post.location}
    locations = grouped_by_location.keys
    locations.map do |loc|
      location_hash = loc.attributes
      location_hash[:posts] = grouped_by_location[loc].as_json(:include => [
        :location,
        {
          :photo => {
            :include => {
              :image => {
                :methods => :service_url
              }
            }
          }
        }])
      # byebug
      # .as_json(:include => { :photo => { :include => {:photo_url} } })

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

  # return format like so:
  # bbox = [
  #   [32.958984, -5.353521],
  #   [43.50585, 5.615985]
  # ]
  def self.set_bbox(features, center = nil)
    if center
      center = center
    elsif features.first
      center = features.first[:geometry][:coordinates]
    else
      center = [0,0]
    end
    north = center[1]
    south = center[1]
    east = center[0]
    west = center[0]

    locations = features.map{|f| f[:geometry][:coordinates]}
    locations.each do |loc|
      lng = loc[0]
      lat = loc[1]

      north = lat if lat > north
      south = lat if lat < south
      east = lng if lng > east
      west = lng if lng < west
    end

    return [[west, north], [east, south]]
  end
end
