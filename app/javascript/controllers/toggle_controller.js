import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown", "hide" ]

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
    this.dropdownTarget.classList.toggle("hidden");
    this.dropdownTarget.innerHTML = ""
    this.dropdownTarget.insertAdjacentHTML('afterbegin', members )
  }

  hide() {
    this.hideTarget.classList.toggle('hidden')

  }


}