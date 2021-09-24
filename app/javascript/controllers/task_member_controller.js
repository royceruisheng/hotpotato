import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown" ]

  connect() {
    console.log("task member controller connected");
  }
  //  dropdown for the add members function
  revealContent() {
    this.dropdownTarget.classList.toggle("hidden");
    
    const url = "/friends"
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then(members => {
        this.dropdownTarget.innerHTML = ""
        this.dropdownTarget.insertAdjacentHTML('afterbegin', members )
      })
    
  }

  // add(event) {
  //   event.preventDefault();

  //   fetch(this.dropdownTarget.action, {
  //     method: 'POST',
  //     headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
  //     body: new DropdownData(this.dropdownTarget)
  //   })
  //     .then(response => response.json())
  //     .then((data) => {
  //       console.log(data)
  //     });
  // }

  new() {
    const url = `/tasks/${ this.element.dataset.itemId }/task_members/new`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.newformTarget.outerHTML = data;
        this.newTarget.classList.toggle("hidden")
      });
  }

  submitForm(e){
    e.preventDefault()
    Rails.fire(this.formTarget, 'submit')
  }
}