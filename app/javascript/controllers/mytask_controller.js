import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["hide", "taskId", "membersdropdown", "taskmemberslist"]

  connect() {
    console.log("toggle controller connected");
  }

  // MY TASKS
  markMyTaskComplete(event) {
    event.preventDefault()
    let taskId = this.element.dataset.taskId
    let workflowId = this.element.dataset.workflowId
    let url = `/tasks/${taskId}/complete_task`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
    // .then(this.insertToWorkflowContent.bind(this))
    // .then(this.checkWorkflowCompletion(workflowId))
  }

}
