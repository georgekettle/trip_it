import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    this.initGeocoder();
  }

  initGeocoder() {
    var searchElement = this.element;
    var geocoder = new MapboxGeocoder({
        accessToken: searchElement.dataset.mapboxToken,
        types: 'country,region,place,postcode,locality,neighborhood'
      });

    geocoder.addTo('#geocoder');

    geocoder.on('result', function(e) {
      // console.log(e.result.text);
        var name = e.result.text;
        var lng = e.result.center[0];
        var lat = e.result.center[1];
        if (name.length > 0) {
          window.location.href = `${window.location.origin}/search/${lng}/${lat}?name=${name}`;
        } else {
          window.location.href = `${window.location.origin}/search/${lng}/${lat}`;
        }

      });
  }
}
