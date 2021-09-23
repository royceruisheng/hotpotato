import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ['contentmain', 'workflowslist', 'workflow']

  connect() {
    console.log('world controller connected')
  }

  createWorkflow(event) {
    const url = '/workflows'
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', "X-CSRF-Token": csrfToken() }
    })
      .then(response => response.text())
      .then((newWorkflow) => {
        this.workflowslistTarget.insertAdjacentHTML('beforeend', newWorkflow);
      })
    fetch(url)
  }

  // Workflow btn states
  selectWorkflow(event) {
    event.currentTarget.classList.toggle('bg-purple-100')
    event.currentTarget.classList.toggle('hover:bg-gray-100')
  }
}
