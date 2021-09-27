import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["hide"];

  hide() {
    this.hideTarget.classList.toggle('hidden')
  }
}
