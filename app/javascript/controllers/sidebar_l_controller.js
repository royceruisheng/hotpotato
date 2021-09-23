import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["dropdown", "workflowslist"]

  connect() {
  }

  createBtnDropdown(event) {
    this.dropdownTarget.classList.toggle('hidden');
  }

  createWorkflow(event) {
    const url = '/workflows'
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', "X-CSRF-Token": csrfToken() },
      body: {}
    })
    .then(response => response.text())
      .then((data) => {
        console.log("data")
      })
  }

}
