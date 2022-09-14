import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  static targets = []

  connect() {
    console.log(`hello from controller display`)
  }

  displayNone(event) {
    console.log("detection")
    this.element.classList.add("d-none")
  }
}
