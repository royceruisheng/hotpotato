import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["hide"];

  hide() {
    this.hideTarget.classList.toggle('hidden')
    // if (this.hideTarget.classList.contains('hidden')) {
    //   this.hideTarget.classList.remove('hidden')
    // } else {
    //   this.hideTarget.classList.add('hidden')
    // }
  }
}
