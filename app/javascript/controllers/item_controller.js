import { csrfToken } from "@rails/ujs";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["new", "newform", "form", "taskcontent", "list", "itemtitle"]

  connect() {
    this.itemsDownloaded = false;
    this.itemsHTML = '';
    console.log("item controller connected")
  }

  getItems() {
    if (!this.itemsDownloaded) {
      fetch(`/workflows/${this.element.dataset.workflowId}/tasks/${this.element.dataset.taskId}`,
        { headers: { 'Accept': 'text/plain' } })
        .then(res => res.text())
        .then(this.storeAndRender.bind(this))
    }
  }

  storeAndRender(items) {
    this.itemsHTML = items;
    this.taskcontentTarget.innerHTML = items;
    this.itemsDownloaded = true;
  }

  new() {
    this.itemtitleTarget.value = ''
    this.newTarget.classList.toggle('hidden')
    this.formTarget.classList.toggle('hidden')
    this.itemtitleTarget.focus();
  }
  closeForm() {
    this.newTarget.classList.toggle("hidden")
    this.formTarget.classList.toggle("hidden")
  }

  submitForm(e){
    e.preventDefault()
    let taskId = this.element.dataset.taskId;
    let itemTitle = this.itemtitleTarget.value;
    fetch('/items', {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ taskId: taskId, title: itemTitle })
    }).then(res => res.text())
      .then(this.insertIntoList.bind(this))
  }

  insertIntoList(newItem) {
    this.listTarget.insertAdjacentHTML('beforeend', newItem)
    this.formTarget.classList.toggle("hidden")
    this.newTarget.classList.toggle("hidden")
  }

  // onPostSuccess(e) {
  //   let [data, status, xhr] = event.detail;
  //   this.commentListTarget.innerHTML += xhr.response;
  //   this.textTarget.value = "";
  //   this.commentErrorsTarget.innerText = "";
  // }

  // action to add a member in a task (requires task_id)
  add(e) {
    // console.log(this.memberTarget);
    e.preventDefault();
    const task_id = this.element.dataset.taskId
    const url = `/tasks/${ task_id }/task_members/`
    // how to pass in the params of user??
    debugger
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain', 'X-CSRF-token': csrfToken() },
      body: JSON.stringify({ task_id: task_id, task_member_id: this.membernamesTarget.dataset.memberId })
    })
    .then(response => response.text())
    .then(this.addMember.bind(this))
  }

  addMember(member) {
    this.memberTarget.insertAdjacentHTML( 'afterbegin', User.find(task_member_id).first_name )
  }
}
