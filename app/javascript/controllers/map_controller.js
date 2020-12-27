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

    JSON.parse(mapContainer.dataset.posts).forEach(post => {
      post.locations.forEach(location => {
        var el = document.createElement('div');
        el.className = 'marker';
        el.dataset.posts = [location.post_id];

        var postCards = Array.from(document.querySelectorAll(`#post-${location.post_id}`));
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
        })

        // make a marker for each feature and add to the map
        var marker = new mapboxgl.Marker(el)
          .setLngLat([location.longitude, location.latitude])
          .addTo(map);

        // var marker = new mapboxgl.Marker({
        //   color: "black"
        // })
        //   .setLngLat([location.longitude, location.latitude])
        //   .addTo(map);
      })
    })
    // JSON.parse(mapContainer.dataset.posts).forEach((post) {
    //   console.log(post);
    // })
    // var marker = new mapboxgl.Marker({
    //   color: "black"
    // })
    //   .setLngLat(coords)
    //   .addTo(map);
  }

  hoverPin() {

  }
}
