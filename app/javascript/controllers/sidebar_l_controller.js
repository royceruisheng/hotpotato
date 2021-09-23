import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['dropdown']

  connect() {
    console.log('sidebar-l controller connected')
  }

  createBtnDropdown(event) {
    this.dropdownTarget.classList.toggle('hidden');
  }

}
