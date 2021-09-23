import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "dropdown" ]

  //  dropdown for the add members function
  revealContent() {
    this.dropdownTarget.classList.toggle("hidden")
  }

  add() {
    // console.log("button is connected");
  }
}