import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of subthemes
  static targets = ["circle1", "circle2", "circle3", "circle4", "circle0","circle5","circle6","circle7","circle9", "circleDiv0", "circleDiv1", "circleDiv2","circleDiv3","circleDiv4", "circleDiv5","circleDiv6","circleDiv7","circleDiv8"]

  connect() {
    console.log(`hello from controller theme show!!!`)
    console.log(this.circle0Targets)
    const themeCount = this.element.dataset.count;

    const self = this

    window.theme_index = 0;

    myLoop(this, themeCount)
  }

}

function myLoop(itself, themeCount) {
  setTimeout(function() {
    console.log(itself)
    console.log("in time out")
    const rotate = parseInt(eval(`itself.circleDiv${theme_index}Target.dataset.rotate${theme_index}`));
    console.log(`rotate${rotate}`)
    const targets = eval(`itself.circle${theme_index}Targets`)
    targets.forEach(circle => circle.style.transform = `rotate(${(rotate)}deg)`)
    console.log(targets[0])
    console.log(targets[1])
    console.log(targets[2])
    theme_index++;
    if (theme_index < themeCount) {
      myLoop(itself, themeCount);
    }
  }, 200)
}
