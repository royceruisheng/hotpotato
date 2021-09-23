
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["new", "newform", 'form']

  connect() {
    console.log("item controller connected")
  }

  new(e) {
    const url = `/items/new`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
        this.newTarget.classList.toggle("hidden")
      });
  }

  submitForm(e){
    e.preventDefault()
    this.formTarget.submit()
  }

  onPostSuccess(event) {
    console.log("success!")
  }
}
