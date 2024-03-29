import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.posts = this.element.dataset.posts;
    this.bbox = JSON.parse(this.element.dataset.bbox);
    this.center = this.calculateCenter(this.bbox);
    this.mapboxToken = this.element.dataset.mapboxToken;
    this.geojson = {
      "type": "FeatureCollection",
      "features": JSON.parse(this.element.dataset.features)
    };
    this.initMap(this.geojson);
  }

  calculateCenter(bbox) {
    let lng = (bbox[0][0] + bbox[1][0]) / 2;
    let lat = (bbox[0][1] + bbox[1][1]) / 2;
    return [lng, lat]
  }

  initMap(geojson) {
    mapboxgl.accessToken = this.mapboxToken;
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: this.center,
      zoom: 4
    });

    map.fitBounds(this.bbox, {
      padding: {top: 60, bottom:60, left: 60, right: 30},
      maxZoom: 13
    });

    // add controls
    map.addControl(new mapboxgl.NavigationControl());

    console.log(geojson);
    map.on('load', function () {
    // Add a new source from our GeoJSON data and
    // set the 'cluster' option to true. GL-JS will
    // add the point_count property to your source data.
    map.addSource('locations', {
    type: 'geojson',
    // Point to GeoJSON data. This example visualizes all M1.0+ locations
    // from 12/22/15 to 1/21/16 as logged by USGS' Earthquake hazards program.
    data: geojson,
    cluster: true,
    clusterMaxZoom: 14, // Max zoom to cluster points on
    clusterRadius: 50 // Radius of each cluster when clustering points (defaults to 50)
    });

    map.addLayer({
    id: 'clusters',
    type: 'circle',
    source: 'locations',
    filter: ['has', 'point_count'],
    paint: {
      // Use step expressions (https://docs.mapbox.com/mapbox-gl-js/style-spec/#expressions-step)
      // with three steps to implement three types of circles:
      //   * Blue, 20px circles when point count is less than 100
      //   * Yellow, 30px circles when point count is between 100 and 750
      //   * Pink, 40px circles when point count is greater than or equal to 750
      'circle-color': ['step',['get', 'point_count'],'#FF6941',100,'#FF6941'],
      'circle-radius': ['step',['get', 'point_count'],15,15,20]
    }
    });

    map.addLayer({
      id: 'cluster-count',
      type: 'symbol',
      source: 'locations',
      filter: ['has', 'point_count'],
      layout: {
        'text-field': '{point_count_abbreviated}',
        'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
        'text-size': 12,
      },
      paint: {
        "text-color": "#ffffff"
      }
    });

    map.addLayer({
      id: 'unclustered-point',
      type: 'circle',
      source: 'locations',
      filter: ['!', ['has', 'point_count']],
      paint: {
        'circle-color': '#FF6941',
        'circle-radius': 5,
        'circle-stroke-width': 1,
        'circle-stroke-color': '#fff'
      }
    });

    // inspect a cluster on click
    map.on('click', 'clusters', function (e) {
      var features = map.queryRenderedFeatures(e.point, {
      layers: ['clusters']
    });
    var clusterId = features[0].properties.cluster_id;
    map.getSource('locations').getClusterExpansionZoom(
      clusterId,
      function (err, zoom) {
        if (err) return;

        map.easeTo({
          center: features[0].geometry.coordinates,
          zoom: zoom
        });
      }
      );
    });

    // When a click event occurs on a feature in
    // the unclustered-point layer, open a popup at
    // the location of the feature, with
    // description HTML from its properties.
    map.on('click', 'unclustered-point', function (e) {
      // console.log(e.target);
      var coordinates = e.features[0].geometry.coordinates.slice();
      // console.log(JSON.parse(e.features[0]["properties"]["posts"]));
      var posts = JSON.parse(e.features[0]["properties"]["posts"]);
      // var mag = e.features[0].properties.mag;
      // var tsunami;

      // if (e.features[0].properties.tsunami === 1) {
      // tsunami = 'yes';
      // } else {
      // tsunami = 'no';
      // }

      // Ensure that if the map is zoomed out such that
      // multiple copies of the feature are visible, the
      // popup appears over the copy being pointed to.
      while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
      };

      var locationId = e.features[0]["properties"]["id"];
      var popup = document.getElementById(`map-popup-location-${locationId}`);
      let popupClone = popup.cloneNode(true);

      new mapboxgl.Popup()
        .setLngLat(coordinates)
        .setDOMContent(popupClone)
        // .setHTML(`<div style="height: 200px;width: 200px" class="mapbox-popup-photo"><img src=${posts[0]["photo"]["image"]["service_url"]} alt=${posts[0]["title"]} width="200" height="200" style="object-fit: cover;min-width: 100%;min-height: 100%;"/></div>`)
        .addTo(map);
      });

      map.on('mouseenter', 'clusters', function () {
        map.getCanvas().style.cursor = 'pointer';
      });
      map.on('mouseleave', 'clusters', function () {
        map.getCanvas().style.cursor = '';
      });
    });
  }
}

// {
//   "type": "FeatureCollection",
//   "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
//   "features": [
//     { "type": "Feature", "properties": { ** post json ** }, "geometry": { "type": "Point", "coordinates": [ -151.5129, 63.1016, 0.0 ] } },
//   ]
// }
