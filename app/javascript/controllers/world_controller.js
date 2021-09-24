import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ['contentmain', 'workflowslist']

  connect() {
    console.log('world controller connected')
  }

  createWorkflow(event) {
    let url = '/workflows'
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', "X-CSRF-Token": csrfToken() }
    })
      .then(response => response.text())
      .then((newWorkflow) => {
        this.workflowslistTarget.insertAdjacentHTML('afterbegin', newWorkflow)
      })
      // .then(response => {
      //   const workflows_id = document.querySelectorAll('#workflow')
      //   fetch(url + "/" + workflows_id[0], {
      //     headers: { 'Accept': 'text/plain' }
      //   })
      // })
      // .then(response => response.text())
  }

  // Workflow btn states
  selectWorkflow(event) {
    event.currentTarget.classList.toggle('bg-purple-100')
    event.currentTarget.classList.toggle('hover:bg-gray-100')
  }
}
