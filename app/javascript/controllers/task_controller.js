import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["new", "newform", "form", "list", "card"]

  connect() {
    console.log("task controller connected")
    const url = `/tasks`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      });
  }

  new(e) {
    const url = `/tasks/new`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
        this.newTarget.classList.toggle("hidden")
      });
  }

  submitForm(e) {
    e.preventDefault()
    this.formTarget.submit()
  }

  getItem(e) {
    e.preventDefault()
    const url = `/items`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
      });
  }
}
