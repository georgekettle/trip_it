import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.initMap();
  }

  initMap() {
    var mapContainer = this.element;
    var coords = JSON.parse(mapContainer.dataset.center);
    console.log(coords);
    mapboxgl.accessToken = mapContainer.dataset.mapboxToken;
    console.log(mapContainer.dataset.mapboxToken);
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: coords,
      zoom: 9
    });
    // var marker = new mapboxgl.Marker({
    //   color: "black"
    // })
    //   .setLngLat(coords)
    //   .addTo(map);
  }
}
