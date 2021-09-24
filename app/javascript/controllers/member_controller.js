import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "dropdown" ]

  //  dropdown for the add members function
  revealContent() {
    this.dropdownTarget.classList.toggle("hidden")
  }

  add(event) {
    event.preventDefault();

    fetch(this.dropdownTarget.action, {
      method: 'POST',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: new DropdownData(this.dropdownTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      });
  }
}