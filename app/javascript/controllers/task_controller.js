import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["new", "newform", "form", "list", "taskslist", 'taskname', "member", "taskId" ]

  connect() {
    console.log("task controller connected")
    const url = `/workflows/${this.element.dataset.workflowId}/tasks`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => this.taskslistTarget.innerHTML = data );
  }

  new() {
    this.tasknameTarget.value = ''
    this.newTarget.classList.toggle("hidden")
    this.formTarget.classList.toggle("hidden")
    this.tasknameTarget.focus();
  }
  closeForm() {
    this.newTarget.classList.toggle("hidden")
    this.formTarget.classList.toggle("hidden")
  }

  submitForm(e) {
    e.preventDefault()
    let workflowId = this.element.dataset.workflowId;
    let taskTitle = this.tasknameTarget.value;
    fetch('/tasks', {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ workflowId: workflowId, taskTitle: taskTitle })
    }).then( res => res.text() )
      .then(this.insertIntoList.bind(this))
  }

  insertIntoList(newTask) {
    this.listTarget.insertAdjacentHTML('beforeend', newTask)
    this.formTarget.classList.toggle("hidden")
    this.newTarget.classList.toggle("hidden")
  }

  markComplete(event){
    event.preventDefault()
    let taskId = event.target.dataset.taskId;
    let workflowId = this.element.dataset.workflowId
    let url = `/tasks/${taskId}/complete_task`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then(this.insertToWorkflowContent.bind(this))
      .then(this.checkWorkflowCompletion(workflowId))
  }

  insertToWorkflowContent(tasklist) {
    document.getElementById('task-list').outerHTML = tasklist
  }

  checkWorkflowCompletion(workflowId) {
    let url = `/workflows/${workflowId}/completion`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      // .then(res => console.log(res))
      .then(response => response.text())
      .then(this.insertToWorkflowStatus.bind(this))
  }

  insertToWorkflowStatus(workflowstatus) {
    console.log(workflowstatus)
    document.getElementById('workflow-status').outerHTML = workflowstatus
  }
}
