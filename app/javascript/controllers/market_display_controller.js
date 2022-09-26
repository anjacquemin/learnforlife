import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["equipement", "quest", "equipementTab", "questTab"]

  connect() {
    console.log(`hello from controller market`)
  }

  displayTab(event) {
    // event.preventDefault()
    console.log("detection")
    this.equipementTarget.classList.toggle("d-none")
    this.questTarget.classList.toggle("d-none")
    this.equipementTabTarget.classList.toggle("active-tab")
    console.log(this.questTabTarget)

    this.questTabTarget.classList.toggle("active-tab")
  }
}
