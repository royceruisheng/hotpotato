import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["toggle"];

  activateToggle() {
    let workflowId = this.element.dataset.workflowId

    fetch('/activate', {
      method: 'PUT',
      headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ workflowId: workflowId })
    })
    .then(response => response.text())
    .then(this.insertToWorkflowContent.bind(this))
  }

  insertToWorkflowContent(workflowContent) {
    document.getElementById('workflow-content').innerHTML = workflowContent
  }
}
