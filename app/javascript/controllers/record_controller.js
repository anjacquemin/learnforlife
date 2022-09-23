// Modal handling : https://symfonycasts.com/screencast/stimulus/modal

import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"
import { Modal } from "bootstrap"
import { myLoop } from "./_my_loop.js"

//to try Animation Skills Progressbar for xp https://www.sliderrevolution.com/design/cool-javascript-animations/

export default class extends Controller {

  static targets = ["achievement1", "circle0", "circleDiv0", "records", "xpDisplay"]

  // Modal for new achievement
  // Dynamic progress display
  connect() {
    console.log(`hello from controller record`)
    if (this.element.dataset.totalUnlockItems >= 1) {
      const modal = new Modal(this.achievement1Target)
      modal.show()
      newLevelTimingAppearance(this.achievement1Target)
    }

    const self = this
    window.theme_index = 0
    myLoop(this, 1);
  }

  quizzLeaderboard(event) {
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

  cancelScroll(event) {
    event.preventDefault()
    console.log("CANCEL scroll")
    // document.location.reload(true)
    // event.stopPropagation()
    console.log(event.target)
    console.log(event.target.parentElement.parentElement.parentElement)

    const quizz_id = event.target.parentElement.parentElement.parentElement.dataset.quizz
    console.log("quizz id")
    console.log(quizz_id)

    // Need to also give the quizz number in the URL

    fetch(`${event.target.href}&quizz_id=${quizz_id}`, {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })
      .then(response => response.json())
      .then((data) => {
        console.log("data received")
        console.log(data)
        if (data.inserted_item) {
          console.log(this.element)
          console.log(data.inserted_item)
          const openned_modal = document.getElementById(`exampleModal${data.quizz_id}`)
          const modal_body = openned_modal.getElementsByClassName('modal-body')[0]
          modal_body.innerHTML = data.inserted_item
        }
      })
  }

  dynamicLevelAppearance(event) {
    const next_modal_id = event.target.dataset.nextModalId
    const modal_div = document.querySelector(`#staticBackdrop${next_modal_id}`)
    newLevelTimingAppearance(modal_div)
  }

}

function newLevelTimingAppearance(modal_div, xpDisplay) {
  if (modal_div.dataset.type === "user_level") {
    const progressbar = modal_div.getElementsByClassName("progressbar")[0]
    console.log(`progressbar${progressbar}`)
    console.log(progressbar)
    const divs_to_display = modal_div.getElementsByClassName("d-none")
    const xpDisplay = modal_div.getElementsByClassName("xp-display")[0]
    console.log(`xpDisplay: ${xpDisplay}`)
    const requiredXp = xpDisplay.dataset.requiredXp
    console.log(`requiredXp: ${requiredXp}`)
    console.log(`divs to display ${divs_to_display}`)
    console.log(divs_to_display)
    delay(progressbar).then(()=> {
      console.log("in the delay")
      Array.from(divs_to_display).forEach(div => div.classList.remove("d-none"))
      xpDisplay.innerHTML = `${requiredXp}/${requiredXp}`
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
