// Modal handling : https://symfonycasts.com/screencast/stimulus/modal

import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"
import { Modal } from "bootstrap"
import { myLoop } from "./_my_loop.js"

//to try Animation Skills Progressbar for xp https://www.sliderrevolution.com/design/cool-javascript-animations/

export default class extends Controller {

  static targets = ["achievement1", "circle0", "circleDiv0", "records"]

  // Modal for new achievement
  // Dynamic progress display
  connect() {
    console.log(`hello from controller`)
    if (this.element.dataset.totalUnlockItems >= 1) {
      const modal = new Modal(this.achievement1Target)
      modal.show()
      newLevelTimingAppearance(this.achievement1Target)
    }

    const self = this
    window.theme_index = 0
    myLoop(this, 1);
  }

  cancelScroll(event) {
    event.preventDefault()
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

  dynamicLevelAppearance(event) {
    const next_modal_id = event.target.dataset.nextModalId
    const modal_div = document.querySelector(`#staticBackdrop${next_modal_id}`)
    newLevelTimingAppearance(modal_div)
  }

}

function newLevelTimingAppearance(modal_div) {
  if (modal_div.dataset.type === "user_level") {
    const progressbar = modal_div.getElementsByClassName("progressbar")[0]
    console.log(`progressbar${progressbar}`)
    console.log(progressbar)
    const divs_to_display = modal_div.getElementsByClassName("d-none")
    console.log(`divs to display ${divs_to_display}`)
    console.log(divs_to_display)
    delay(progressbar).then(()=> {
      console.log("in the delay")
      Array.from(divs_to_display).forEach(div => div.classList.remove("d-none"))
    });
  }
}

function delay(progressbar) {
  return new Promise(resolve => {
    setTimeout(function() {
      progressbar.style.width = "100%"
      console.log("in the second timeout")
    },1000);
    setTimeout(() => {
      console.log("in the second timeout")
      resolve("data")
    }, 3000);
  });
}
