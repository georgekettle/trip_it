import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.locations = JSON.parse(this.element.dataset.locations);
    this.posts = this.element.dataset.posts;
    this.coords = JSON.parse(this.element.dataset.center);
    this.mapboxToken = this.element.dataset.mapboxToken;
    this.initMap();
  }

  initMap() {
    mapboxgl.accessToken = this.mapboxToken;
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: this.coords,
      zoom: 9
    });

    console.log(this.locations);

    JSON.parse(this.posts).forEach(post => {
      var location = post.location;
      var el = document.createElement('div');
      el.className = 'marker';

      var postCards = Array.from(document.querySelectorAll(`[data-location="${location.id}"]`));
      console.log(postCards);

      el.addEventListener('mouseenter', (e) => {
        // add class to each of the associated posts
        postCards.forEach(post => post.classList.add('active'));
      });
      el.addEventListener('mouseleave', (e) => {
        // add class to each of the associated posts
        postCards.forEach(post => post.classList.remove('active'));
      });

      // add onclick event to show image preview
      postCards.forEach(postCard => {
        postCard.addEventListener('mouseenter', (e) => {
          el.classList.add('active');
        });
        postCard.addEventListener('mouseleave', (e) => {
          el.classList.remove('active');
        })
      });

      // make a marker for each feature and add to the map
      var marker = new mapboxgl.Marker(el)
        .setLngLat([location.longitude, location.latitude])
        .addTo(map);
    })
  }

  markerMouseEnter() {

  }
}
