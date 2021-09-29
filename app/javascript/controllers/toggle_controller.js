import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown", "membersdropdown", "taskmemberslist", "hide", "taskTitle", "taskTitleForm" ]

  connect() {
    console.log("toggle controller connected");
  }
  //  TSK MEMBERS
  dropdownAddMembers() {
    const url = `/tasks/${this.element.dataset.taskId}/task_members/new`
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
    const task_id = this.element.dataset.taskId
    const member_btn = e.currentTarget
    const member_id = member_btn.dataset.memberId
    const url = `/tasks/${task_id}/task_members/`

    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-token': csrfToken() },
      body: JSON.stringify({ task_id: task_id, member_id: member_id })
    })
    .then(response => response.text())
    .then(data => {
      this.addMemberToTaskmembers(data)
      member_btn.parentElement.removeChild(member_btn)
    })
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
    .then(this.element.parentElement.removeChild(this.element))
  }
}
