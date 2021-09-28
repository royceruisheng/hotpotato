import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [];

  activateWorkflowToggle() {
    let workflowId = this.element.dataset.workflowId

    fetch('/activate', {
      method: 'PUT',
      headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ workflowId: workflowId })
    })
    .then(response => response.text())
    .then(this.insertToWorkflowContent.bind(this))

    let prevSelected = document.querySelector('.t-sidetab-btn-active')
    prevSelected.classList.remove('t-sidetab-btn-active')
    prevSelected.classList.add('t-sidetab-btn')
    this.element.classList.remove('t-sidetab-btn')
    this.element.classList.add('t-sidetab-btn-active')
  }

  insertToWorkflowContent(workflowContent) {
    document.getElementById('workflow-content').innerHTML = workflowContent
  }
}
