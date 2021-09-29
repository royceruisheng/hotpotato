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


  // My Tasks
  selectMyTask() {
    fetch(`/tasks/${this.element.dataset.taskId}/show_mytask`, {
      headers: { 'Accept': 'text/plain' }
    })
      .then(response => response.text())
      .then(this.insertToMyTasksContent.bind(this))

    let prevSelected = document.querySelector('.t-sidetab-btn-active')
    if (prevSelected) {
      prevSelected.classList.remove('t-sidetab-btn-active')
      prevSelected.classList.add('t-sidetab-btn')
    }
    this.element.classList.remove('t-sidetab-btn')
    this.element.classList.add('t-sidetab-btn-active')
  }

  insertToMyTasksContent(mytasksContent) {
    let holder = document.getElementById('mytask-content')
    holder.innerHTML = ''
    holder.innerHTML = mytasksContent
  }

}
