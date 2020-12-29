import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.posts = this.element.dataset.posts;
    this.coords = JSON.parse(this.element.dataset.center);
    this.mapboxToken = this.element.dataset.mapboxToken;
    this.geojson = {
      "type": "FeatureCollection",
      "features": JSON.parse(this.element.dataset.features)
    };
    this.initMap(this.geojson);
  }

  initMap(geojson) {
    mapboxgl.accessToken = this.mapboxToken;
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: this.coords,
      zoom: 9
    });

    // console.log(this.features);

    // this.addMarkers(map);

    // JSON.parse(this.posts).forEach(post => {
    //   var location = post.location;
    //   var el = document.createElement('div');
    //   el.className = 'marker';

    //   var postCards = Array.from(document.querySelectorAll(`[data-location="${location.id}"]`));
    //   console.log(postCards);

    //   el.addEventListener('mouseenter', (e) => {
    //     // add class to each of the associated posts
    //     postCards.forEach(post => post.classList.add('active'));
    //   });
    //   el.addEventListener('mouseleave', (e) => {
    //     // add class to each of the associated posts
    //     postCards.forEach(post => post.classList.remove('active'));
    //   });

    //   // add onclick event to show image preview
    //   postCards.forEach(postCard => {
    //     postCard.addEventListener('mouseenter', (e) => {
    //       el.classList.add('active');
    //     });
    //     postCard.addEventListener('mouseleave', (e) => {
    //       el.classList.remove('active');
    //     })
    //   });

    //   // make a marker for each feature and add to the map
    //   var marker = new mapboxgl.Marker(el)
    //     .setLngLat([location.longitude, location.latitude])
    //     .addTo(map);
    // })

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
      'circle-color': ['step',['get', 'point_count'],'red',100,'red'],
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
        'circle-color': 'red',
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
      var coordinates = e.features[0].geometry.coordinates.slice();
      console.log(JSON.parse(e.features[0]["properties"]["posts"]));
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
      }


      new mapboxgl.Popup()
        .setLngLat(coordinates)
        .setHTML(`<div style="height: 200px;width: 200px"><img src=${posts[0]["photo"]["url"]} alt=${posts[0]["title"]} width="200" height="200" style="object-fit: cover;"/></div>`)
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

  addMarkers(map) {

  }

  markerMouseEnter() {

  }
}

// {
//   "type": "FeatureCollection",
//   "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
//   "features": [
//     { "type": "Feature", "properties": { ** post json ** }, "geometry": { "type": "Point", "coordinates": [ -151.5129, 63.1016, 0.0 ] } },
//   ]
// }
