import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["new", "newform", "form", "list", 'taskname']

  connect() {
    console.log("task controller connected")
    const url = `/workflows/${this.element.dataset.workflowId}/tasks`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => this.listTarget.innerHTML = data );
  }

  new() {
    const url = `/tasks/new`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
        this.newTarget.classList.toggle("hidden")
      });
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
}
