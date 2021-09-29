import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [""]

  connect() {
    console.log("notification controller connected")
  }

  sendemail(event) {
    event.preventDefault()
    let taskId = this.element.dataset.taskId;
    let url = `/tasks/${taskId}/email_notification`
    fetch(url)
    // fetch(url, { headers: { 'Accept': 'text/plain' } })
  }

}
