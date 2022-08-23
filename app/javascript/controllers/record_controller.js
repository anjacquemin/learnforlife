// Modal handling : https://symfonycasts.com/screencast/stimulus/modal

import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"
import { Modal } from "bootstrap"


//to try Animation Skills Progressbar for xp https://www.sliderrevolution.com/design/cool-javascript-animations/

export default class extends Controller {

  static targets = ["achievement1", "circle0", "circleDiv0"]

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

    for (var i=0; i<1; i++) {
      rotate = parseInt(eval(`this.circleDiv${i}Target.dataset.rotate${i}`));
      targets = eval(`this.circle${i}Targets`)
      targets.forEach(circle => circle.style.transform = `rotate(${(rotate)}deg)`)
    }
  }

}
