import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]

  // initialize() {
  //   var dropdowns = Array.from(document.querySelectorAll("[data-controller='dropdown']"));
  //   // var html = document.getElementsByTagName("HTML")[0];
  //   window.addEventListener('DOMContentLoaded', (event) => {
  //     document.addEventListener('click', function(e) {
  //       dropdowns.forEach((e) => {
  //         console.log('element', e);
  //         // d.addEventLister('click', (e) => {
  //         //   console.log('hello');
  //         // })
  //       })
  //     })
  //   });


  // }

  // setupClickOutside() {
  //   document.addEventListener('click', function(e) {
  //     dropdowns.forEach((e) => {
  //       console.log('element', e);
  //       // d.addEventLister('click', (e) => {
  //       //   console.log('hello');
  //       // })
  //     })
  //   })
  // }

  clickOutsideToClose(dropdown) {
    dropdown.classList.toggle('display-none');
    console.log(dropdown);
  }

  toggle() {
    this.toggleableTarget.classList.toggle('display-none');
    // document.addEventListener('click', (e) => {
    //   console.log(e.currentTarget);
    //   if (e.currentTarget === this.toggleableTarget) {
    //     this.toggleableTarget.classList.remove('display-none');
    //   } else {
    //     this.toggleableTarget.classList.add('display-none');
    //   }
    // });
  }
}
