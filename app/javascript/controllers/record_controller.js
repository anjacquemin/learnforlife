// Modal handling : https://symfonycasts.com/screencast/stimulus/modal

import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"
import { Modal } from "bootstrap"
import { myLoop } from "./_my_loop.js"

//to try Animation Skills Progressbar for xp https://www.sliderrevolution.com/design/cool-javascript-animations/

export default class extends Controller {

  static targets = ["achievement1", "circle0", "circleDiv0", "records"]

  connect() {
    console.log(`hello from controller`)
    console.log(this.element)
    // this.achievementTarget.modal('show')
    // Modal for new achievement
    if (this.element.dataset.totalUnlockItems >= 1) {
      const modal = new Modal(this.achievement1Target)
      modal.show()
    }

    // Dynamic progress display
    let rotate = 0
    let targets
    const self = this
    window.theme_index = 0
    myLoop(this, 1);
  }

  cancelScroll(event) {
    event.preventDefault()
    // document.location.reload(true)
    // event.stopPropagation()
    console.log(event.target)
    fetch(event.target.href, {
      method: "GET",
      headers: {"Accept": "application/json"},
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.recordsTarget.innerHTML = data.inserted_item
        }
      })
  }

}
