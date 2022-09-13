import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["logIn", "signIn"]

  connect() {
    console.log(`hello from controller`)
  }

  displayLoginSignIn(event) {
    event.preventDefault()
    console.log("detection")
    this.logInTarget.classList.toggle("d-none")
    this.signInTarget.classList.toggle("d-none")
  }


}
