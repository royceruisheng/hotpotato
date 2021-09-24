
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["new", "newform", "form", "list"]

  connect() {
    this.itemsDownloaded = false;
    this.itemsHTML = '';
    console.log("item controller connected")
  }

  getItems() {
    if (!this.itemsDownloaded) {
      fetch(`/tasks/${this.element.dataset.itemId}`,
        { headers: { 'Accept': 'text/plain' } })
        .then(res => res.text())
        .then(this.storeAndRender.bind(this))
        // .then((data) => {
        //   this.listTarget.outerHTML = data
        // })
    }
  }

  storeAndRender(items) {
    this.itemsHTML = items;
    this.listTarget.outerHTML = this.itemsHTML;
    this.itemsDownloaded = true;
  }

  new() {
    const url = `/tasks/${ this.element.dataset.itemId }/items/new`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
        this.newTarget.classList.toggle("hidden")
      });
  }

  submitForm(e){
    e.preventDefault()
    Rails.fire(this.formTarget, 'submit')
  }

  // onPostSuccess(e) {
  //   let [data, status, xhr] = event.detail;
  //   this.commentListTarget.innerHTML += xhr.response;
  //   this.textTarget.value = "";
  //   this.commentErrorsTarget.innerText = "";
  // }

}
