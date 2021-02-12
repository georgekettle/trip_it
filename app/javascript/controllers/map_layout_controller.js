import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "container" ]

  toggleMap(e) {
    e.preventDefault();
    this.containerTarget.classList.toggle('enlarge-map');
    window.dispatchEvent(new Event('resize'));
  }
}
