import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown", "member", "membernames" ]

  connect() {
    console.log("task member controller connected");
  }
  //  dropdown for the add members function
  revealContent() {
    
    const url = "/friends"
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then(this.updateAndHide.bind(this))
  }

  updateAndHide(members) {
    this.dropdownTarget.classList.toggle("hidden");
    this.dropdownTarget.innerHTML = ""
    this.dropdownTarget.insertAdjacentHTML('afterbegin', members )
  }


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

  // submitForm(e){
  //   e.preventDefault()
  //   Rails.fire(this.formTarget, 'submit')
  // }


  // sampleFunction() {
  //   fetch(whatever)
  //     .then(res => res.json())
  //     .then(data => this.doSomething(data).bind(this))
  // }
}