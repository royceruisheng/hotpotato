import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["toggle"];

  activateToggle() {
    this.hideTarget.classList.toggle('hidden')

  }
}
