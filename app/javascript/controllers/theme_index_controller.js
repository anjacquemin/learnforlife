import { Controller } from "@hotwired/stimulus"
import { circleDivTargets, circleTargets } from  "./_circle_targets_constant.js"
import { Modal } from "bootstrap"


export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["themeDiv", "leaderboardDiv","achievement1"].concat(circleDivTargets).concat(circleTargets)

  connect() {
    console.log(`hello from controller index index`)
    console.log(this.circleDiv0Target)
    console.log(this.circle0Targets)
    console.log(this.circleDiv0Target.dataset.rotate)
    console.log(this.element)
    console.log(this.element.dataset)
    console.log(this.element.dataset.count)

    const themeCount = this.element.dataset.count;
    const self = this
    window.theme_index = 0;

    let rotate = 0
    let targets

    myLoop(this, themeCount);

    // Display achievements
    console.log(`total unlocked achievements : ${this.element.dataset.totalUnlockedAchievements}`)
    if (this.element.dataset.totalUnlockedAchievements >= 1) {
      console.log("display modal")
      console.log(this.achievement1Target)
      const modal = new Modal(this.achievement1Target)
      modal.show()
    }
  }
}

function myLoop(itself, themeCount) {
  setTimeout(function() {
    const rotate = parseInt(eval(`itself.circleDiv${theme_index}Target.dataset.rotate${theme_index}`));
    const targets = eval(`itself.circle${theme_index}Targets`)
    targets.forEach(circle => circle.style.transform = `rotate(${(rotate)}deg)`)
    theme_index++;
    if (theme_index < themeCount-1) {
      myLoop(itself, themeCount);
    }
  }, 200)
}
