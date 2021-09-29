import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown", "taskId", "membersdropdown", "taskmemberslist", "hide", "taskTitle", "taskTitleForm" ]

  connect() {
    console.log("toggle controller connected");
  }
  //  TSK MEMBERS
  dropdownAddMembers() {
    const url = "/task_members/new"
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then(this.updateAndHide.bind(this))
  }
  updateAndHide(members) {
    this.membersdropdownTarget.classList.toggle("hidden");
    this.membersdropdownTarget.innerHTML = ""
    this.membersdropdownTarget.insertAdjacentHTML('afterbegin', members )
  }

  addMember(e) {
    e.preventDefault();
    const task_id = this.taskIdTarget.dataset.taskId
    const member_id = e.currentTarget.dataset.memberId
    const url = `/tasks/${task_id}/task_members/`

    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-token': csrfToken() },
      body: JSON.stringify({ task_id: task_id, member_id: member_id })
    })
    .then(response => response.text())
    .then(this.addMemberToTaskmembers.bind(this))
  }
  addMemberToTaskmembers(member) {
    this.taskmemberslistTarget.insertAdjacentHTML('beforeend', member)
  }

  // generic hider
  hide() {
    this.hideTarget.classList.toggle('hidden')
  }
  
  toggleHideTitleForm() {
    this.hideTarget.classList.toggle('hidden')
    this.taskTitleTarget.classList.toggle('hidden')
    this.taskTitleFormTarget.classList.toggle('hidden')
  }

  // TASKS
  deleteTask(e) {
    e.preventDefault();
    const task_id = this.element.dataset.taskId
    const url = `/tasks/${task_id}`
    
    fetch(url, {
      method: 'DELETE',
      headers: { 'X-CSRF-token': csrfToken() }
    })
    .then(response => response.json())
    .then(this.element.parentElement.removeChild(this.element))
  }

  // MY TASKS
  markMyTaskComplete(event) {
    event.preventDefault()
    let taskId = this.element.dataset.taskId
    let workflowId = this.element.dataset.workflowId
    let url = `/tasks/${taskId}/complete_mytask`
    fetch(url)
      // .then(response => response.text())
      // .then(this.insertToWorkflowContent.bind(this))
      // .then(this.checkWorkflowCompletion(workflowId))
  }
}
