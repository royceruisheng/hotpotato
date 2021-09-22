import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
  }

  toggle(event) {
    this.menuTarget.classList.toggle('hidden');
  }
}
