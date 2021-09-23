import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["dropdown"]

  connect() {
  }

  createBtnDropdown(event) {
    console.log('connected')
    this.dropdownTarget.classList.toggle('hidden');
  }
}
