import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["activated"]

  connect() {
    console.log(this.activatedTarget);
  }
}