import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "title"]

  connect() {
    console.log("workflow controller connected")
  }

  // new() {
  //   const url = `/tasks/new`
  //   fetch(url, { headers: { 'Accept': 'text/plain' } })
  //     .then(response => response.text())
  //     .then((data) => {
  //       this.newformTarget.outerHTML = data;
  //       this.newTarget.classList.toggle("hidden")
  //     });
  // }

  // submitForm(e) {
  //   e.preventDefault();
  //   Rails.fire(this.formTarget, 'submit');
  // }


}
