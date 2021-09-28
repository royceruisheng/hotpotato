import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown", "taskId", "membersdropdown", "taskmemberslist", "hide", "taskTitle", "editItemTitleForm", "changeTitleInput", "currentTaskId", "currentWorkflowId", "editItemButton", "changeDescriptionInput", "taskDescription" ]

  connect() {
    console.log("toggle controller connected");
  }
  //  dropdown for the add members function
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
    this.hideTarget.classList.toggle('hidden');
    this.editItemButtonTarget.classList.toggle('hidden');
  }

  // shows the form to edit current task title
  displayEditTitleForm() {
    this.editItemTitleFormTarget.classList.toggle("hidden");
    this.taskTitleTarget.classList.toggle("hidden");
    this.taskDescriptionTarget.classList.toggle("hidden");
    this.changeDescriptionInputTarget.classList.toggle("hidden");
  }

  updateTaskTitle(e) {
    e.preventDefault();
    // console.log(this.currentTaskIdTarget.value);
    // console.log(this.currentWorkflowIdTarget.value);

    const current_task_id = this.currentTaskIdTarget.value
    const current_workflow_id = this.currentWorkflowIdTarget.value
    const task_title = this.changeTitleInputTarget.value
    const task_description = this.changeDescriptionInputTarget.value
    const url = `/workflows/${current_workflow_id}/tasks/${current_task_id}`
    
    fetch(url, {
      method: 'PUT',
      headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ task_title: task_title, task_description: task_description })
    })
    .then(response => response.text())
    .then((data) => {
      // console.log(data);
      this.taskTitleTarget.innerHTML = task_title
      this.taskDescriptionTarget.innerHTML = task_description
      this.editItemTitleFormTarget.classList.add("hidden");
      this.taskTitleTarget.classList.remove("hidden");
      this.taskDescriptionTarget.classList.remove("hidden");
      this.changeDescriptionInputTarget.classList.add("hidden");
    })
  }
}
