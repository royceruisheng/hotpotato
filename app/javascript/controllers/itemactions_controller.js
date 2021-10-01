import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["expandedCard", "itemDescription", "itemDescriptionInput", "itemForm"]

  connect() {
    this.contentDownloaded = false;
    this.contentHTML = '';
    console.log("itemactions controller connected")
  }


  deleteItem(e) {
    e.preventDefault();

    const item_id = this.element.dataset.itemId
    const url = `/items/${item_id}`

    fetch(url, {
      method: 'DELETE',
      headers: { 'X-CSRF-token': csrfToken() }
    })
    .then(this.element.remove()
    )
  }

  expandItem(e) {
    e.preventDefault()

    const itemId = this.element.dataset.itemId
    fetch(`/items/${itemId}/expand`, {
      headers: {}
    })
    .then(res => res.text())
    .then(this.renderItemContent.bind(this))
  }
  renderItemContent(content) {
    this.expandedCardTarget.innerHTML = content
    this.expandedCardTarget.classList.toggle('hidden')
    this.contentHTML = content;
    this.contentDownloaded = true;
  }

  closeItem(e) {
    this.expandedCardTarget.classList.toggle('hidden')
  }

  saveDescription(e) {
    const input = this.itemDescriptionInputTarget.value
    const itemId = this.element.dataset.itemId

    fetch(`/items/${itemId}`, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain', 'X-CSRF-token': csrfToken() },
      body: JSON.stringify({description: input})
    })
      .then(res => res.text())
      .then(this.insertIntoItemCard.bind(this))
  }
  insertIntoItemCard(content) {
    this.expandedCardTarget.innerHTML = content
  }

  editForm() {
    this.itemDescriptionTarget.classList.toggle('hidden')
    this.itemFormTarget.classList.toggle('hidden')
  }
}
