import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["new", "newform", "form", "list", "itemtitle"]

  connect() {
    this.itemsDownloaded = false;
    this.itemsHTML = '';
    console.log("item controller connected")
  }

  getItems() {
    if (!this.itemsDownloaded) {
      fetch(`/tasks/${this.element.dataset.taskId}`,
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
    const url = `/tasks/${ this.element.dataset.taskId }/items/new`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
        this.newTarget.classList.toggle("hidden")
      });
  }

  submitForm(e){
    e.preventDefault()
    let taskId = this.element.dataset.taskId;
    let itemTitle = this.itemtitleTarget.value;
    fetch('/items', {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ taskId: taskId, title: itemTitle })
    }).then(res => res.text())
      .then(this.insertIntoList.bind(this))
  }

  insertIntoList(newItem) {
    this.listTarget.insertAdjacentHTML('beforeend', newItem)
    this.formTarget.classList.toggle("hidden")
    this.newTarget.classList.toggle("hidden")
  }

  // onPostSuccess(e) {
  //   let [data, status, xhr] = event.detail;
  //   this.commentListTarget.innerHTML += xhr.response;
  //   this.textTarget.value = "";
  //   this.commentErrorsTarget.innerText = "";
  // }

}
