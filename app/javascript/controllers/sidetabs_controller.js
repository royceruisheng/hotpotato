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

    let prevSelected = document.querySelector('.t-workflow-btn-active')
    prevSelected.classList.remove('t-workflow-btn-active')
    prevSelected.classList.add('t-workflow-btn')
    this.element.classList.remove('t-workflow-btn')
    this.element.classList.add('t-workflow-btn-active')
    // fetch('/workflows_tabs', {
    //   method: 'POST',
    //   headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
    //   body: JSON.stringify({ workflowId: workflowId })
    // })
    // .then(response => response.text())
    // .then(this.insertToWorkflowTabs.bind(this))
  }

  insertToWorkflowContent(workflowContent) {
    document.getElementById('workflow-content').innerHTML = workflowContent
  }
  // insertToWorkflowTabs(workflowTabs) {
  //   document.getElementById('workflow-tabs').outerHTML = workflowTabs
  // }
}
