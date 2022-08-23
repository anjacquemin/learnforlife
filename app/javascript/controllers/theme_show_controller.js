import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of subthemes
  static targets = ["circle1", "circle2", "circle3", "circle4", "circle0","circle5","circle6","circle7","circle9", "circleDiv0", "circleDiv1", "circleDiv2","circleDiv3","circleDiv4", "circleDiv5","circleDiv6","circleDiv7","circleDiv8"]

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

    let rotate = 0
    let targets

    for (var i=0; i<themeCount; i++) {
      rotate = parseInt(eval(`this.circleDiv${i}Target.dataset.rotate${i}`));
      targets = eval(`this.circle${i}Targets`)
      targets.forEach(circle => circle.style.transform = `rotate(${(rotate)}deg)`)
    }
  }

}
