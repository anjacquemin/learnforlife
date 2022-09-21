import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["global", "theme", "globalTab", "themeTab"]

  connect() {
    console.log(`hello from controller success`)
  }

  displayGlobalOrTheme(event) {
    // event.preventDefault()
    console.log("detection")
    this.globalTarget.classList.toggle("d-none")
    this.themeTarget.classList.toggle("d-none")
    this.globalTabTarget.classList.toggle("active-tab")
    this.themeTabTarget.classList.toggle("active-tab")
  }
}
