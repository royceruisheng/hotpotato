import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["new", "newform", "form", "list", 'taskname', "member", "membernames" ]

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

    // const url = `/tasks/new`
    // fetch(url, { headers: { 'Accept': 'text/plain' } })
    //   .then(response => response.text())
    //   .then((data) => {
    //     this.newformTarget.innerHTML = data;
    //     this.newTarget.classList.toggle("hidden")
    //   });
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

  // action to add a member in a task (requires task_id)
  add(e) {
    // console.log(this.memberTarget);
    e.preventDefault();
    const url = `/tasks/${ this.element.dataset.taskId }/task_members/`
    // how to pass in the params of user??
    fetch(url, { 
        method: 'POST', 
        headers: { 'Accept': 'text/plain', 'X-CSRF-token': csrfToken() }, 
        body: JSON.stringify({ task_member_id: this.membernamesTarget.dataset.memberId })
    })
    .then(response => response.text())
    .then(this.addMember.bind(this))
  }

  addMember(member) {
    console.log(member)
    this.memberTarget.insertAdjacentHTML( 'afterbegin', member.first_name )
  }
}
