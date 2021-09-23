
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["new", "newform", "form", "listinject"]

  connect() {
    this.itemsDownloaded = false;
    this.itemsHTML = '';
    console.log("item controller connected")
    const url = `/items`
    // fetch(url, { headers: { 'Accept': 'text/plain' } })
    //   .then(response => response.text())
    //   .then((data) => {
    //     this.listTarget.outerHTML = data;
    //   });
  }

  toggleList() {
    if (this.listinjectTarget.classList.contains('hidden')) {
      this.listinjectTarget.classList.remove('hidden')
    } else {
      this.listinjectTarget.classList.add('hidden')
    }
  }


  getItems() {
    if (!this.itemsDownloaded) {
      fetch(`/tasks/${this.element.dataset.itemId}`,
        { headers: { 'Accept': 'text/plain' } })
        .then(res => res.text())
        .then(this.storeAndRender.bind(this))
        .then(this.toggleList.bind(this));
    } else {
      console.log('first call')
      this.toggleList();
    }
  }

  storeAndRender(items) {
    this.itemsHTML = items;
    this.listinjectTarget.outerHTML = this.itemsHTML;
    this.itemsDownloaded = true;
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
}
