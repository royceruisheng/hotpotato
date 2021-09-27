import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "membersdropdown", "hide" ]

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

  // generic hider
  hide() {
    this.hideTarget.classList.toggle('hidden')
  }

}
