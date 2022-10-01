import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"
import { Modal } from "bootstrap"



export default class extends Controller {

  // number of circle target = number of subthemes
  static targets = ["avatar", "head", "hair", "body","helmet", "weapon","shield", "headModal", "hairModal","helmetModal", "weaponModal" , "shieldModal", "bodyModal", "characterInfo"]

  connect() {
    console.log(`hello from controller sprite!!!`)
    console.log(this.element.dataset.characterInfo)
    if (this.element.dataset.characterInfo === "true") {
      console.log(this.element.dataset.characterInfo)
      console.log("ici")
      const modal = new Modal(this.characterInfoTarget)
      modal.show()
    }
  }

  changeUserSprite(event) {

    const corrected_target = event.target.hasAttribute("data-type") ? event.target : event.target.parentElement

    console.log (corrected_target)
    const img_src = corrected_target.dataset.src
    console.log(img_src)
    const type = corrected_target.dataset.type
    console.log(type)

    console.log(this.weaponModalTarget)
    console.log(this.helmetModalTarget)
    console.log(this.hairModalTarget)


    let img_to_change = ""

    if(type === "hair") {
      img_to_change = this.hairModalTarget
    } else if (type === "body") {
      img_to_change = this.bodyModalTarget
    } else if (type === "head") {
      img_to_change = this.headModalTarget
    } else if (type === "helmet") {
      img_to_change = this.helmetModalTarget
    } else if (type === "weapon") {
      img_to_change = this.weaponModalTarget
    } else if (type === "shield") {
      img_to_change = this.shieldModalTarget
    }

    console.log(img_to_change)

    img_to_change.src = img_src
  }

  confirm(event) {
    console.log("CLICK ON BUTTON DETECTED")
    event.preventDefault()
    const url = event.target.dataset.url
    const hair = this.hairModalTarget.src
    const head = this.headModalTarget.src
    const body = this.bodyModalTarget.src
    const helmet = this.helmetModalTarget.src
    const weapon = this.weaponModalTarget.src
    const shield = this.shieldModalTarget.src
    console.log(hair)
    console.log(head)
    console.log(body)
    console.log(helmet)
    console.log(weapon)
    console.log(shield)
    let data = answerDataBuilding(hair, head, body, helmet, weapon, shield)

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: data
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data.inserted_item)
      this.avatarTarget.innerHTML = data.inserted_item
    })
  }
}


const answerDataBuilding = (hair, head, body, helmet, weapon, shield) => {
  let payload = {
    type: "character-info",
    hair: hair,
    head: head,
    body: body,
    helmet: helmet,
    weapon: weapon,
    shield: shield
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}
