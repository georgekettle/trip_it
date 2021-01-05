import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input", "preview", "previewContainer", "new" ]

  updatePreview(e) {
    // update DOM state
    this.newTarget.classList.add('display-none');
    this.previewContainerTarget.classList.remove('display-none');
    // create image
    let src = window.URL.createObjectURL(this.inputTarget.files[0]);
    let img = document.createElement('img');
    img.src = src;
    // set image on DOM
    this.previewTarget.innerHTML = '';
    this.previewTarget.appendChild(img);
  }

  openImageSelect(e) {
    this.inputTarget.click();
  }
}
