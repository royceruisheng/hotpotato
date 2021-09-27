import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["new", "newform", "form", "list", 'taskname', "member", "taskId" ]

  connect() {
    console.log("task controller connected")
    const url = `/workflows/${this.element.dataset.workflowId}/tasks`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => this.listTarget.innerHTML = data );
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
    let url = `/tasks/${taskId}/completed`
    console.log(url)
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then(this.insertToWorkflowContent.bind(this))
  }

  insertToWorkflowContent(workflowContent) {
    document.getElementById('workflow-content').innerHTML = workflowContent
  }

    // action to add a member in a task (requires task_id)
  addMember(e) {
    e.preventDefault();
    const task_id = this.taskIdTarget.dataset.taskId
    const member_id = e.currentTarget.dataset.memberId
    const url = `/tasks/${ task_id }/task_members/`

    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-token': csrfToken() },
      body: JSON.stringify({ task_id: task_id, member_id: member_id })
    })
    // .then(response => response.text())
    // .then(this.addMember.bind(this))
  }

  addMembertosomething(member) {
    this.memberTarget.insertAdjacentHTML( 'afterbegin', User.find(task_member_id).first_name )
  }
}
