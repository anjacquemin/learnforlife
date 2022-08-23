import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["circle1", "circle2", "circle3", "circle4", "circle0", "circleDiv0", "circleDiv1", "circleDiv2","circleDiv3","circleDiv4"]

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
      // console.log("loop")
      // console.log(i)
      // console.log(eval(`this.circleDiv${i}Target`))
      rotate = parseInt(eval(`this.circleDiv${i}Target.dataset.rotate${i}`));
      targets = eval(`this.circle${i}Targets`)
      targets.forEach(circle => circle.style.transform = `rotate(${(rotate)}deg)`)
    }
  }

}
