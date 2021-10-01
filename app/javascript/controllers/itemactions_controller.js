import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["itemCard"]

  connect() {
    console.log("itemactions controller connected")
  }


  deleteItem(e) {
    e.preventDefault();

    const item_id = this.element.dataset.itemId
    console.log(item_id)
    const url = `/items/${item_id}`

    fetch(url, {
      method: 'DELETE',
      headers: { 'X-CSRF-token': csrfToken() }
    })
    .then(this.element.remove()
    )
  }

  editItemForm(e) {
    e.preventDefault()
    fetch()
  }
}
