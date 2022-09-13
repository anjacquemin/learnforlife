import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["form", "logIn", "signIn", "name", "email", "password", "passwordConfirmation"]

  connect() {
    console.log(`hello from controller`)
  }

  displayLoginSignIn(event) {
    event.preventDefault()
    console.log("detection")
    this.logInTarget.classList.toggle("d-none")
    this.signInTarget.classList.toggle("d-none")
  }

  registration(event) {
    event.preventDefault()
    console.log("click detect")
    const url = this.element.dataset.url
    const email = this.emailTarget.value
    const password = this.passwordTarget.value
    const passwordConfirmation = this.passwordConfirmationTarget.value
    const name = this.nameTarget.value
    console.log (email)
    console.log (password)
    console.log (passwordConfirmation)
    console.log(url)

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: dataBuilding(name, email, password, passwordConfirmation)
    })
      .then(response => response.json())
      .then((data) => {
        console.log("data received")
        console.log(data)
        if (data.inserted_item) {
          this.formTarget.innerHTML = data.inserted_item
          this.element.insertAdjacentHTML("beforeend", data.flash_item)
        }
        else if (data.location) {
          window.location = data.location;
        }
      })
  }
}


const dataBuilding = (name, email, password, password_confirmation) => {
  let payload = {
    "user": {
      type: "character-info",
      name: name,
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}
