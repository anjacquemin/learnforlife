import { Controller } from "@hotwired/stimulus"
import { circleDivTargets, circleTargets } from  "./_circle_targets_constant.js"


export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["themeDiv", "leaderboardDiv"].concat(circleDivTargets).concat(circleTargets)

  connect() {
    console.log(`hello from controller`)
    console.log(this.circleDiv0Target)
    console.log(this.circle0Targets)
    console.log(this.circleDiv0Target.dataset.rotate)
    // this.achievementTarget.modal('show')
    console.log(this.element)
    console.log(this.element.dataset)
    console.log(this.element.dataset.count)

    const themeCount = this.element.dataset.count;
    const self = this
    window.theme_index = 0;

    let rotate = 0
    let targets

    myLoop(this, themeCount);

  }

  displayQuizzsDiv() {
    console.log("click detected")
    theme_div = this.themeDivTarget
    leaderboard_div = this.leaderboardDivTarget

    theme_div.classlist.toggle("d-none")
    leaderboard_div.classlist.toggle("d-none")
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
