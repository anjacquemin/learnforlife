import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  static targets = ["records"]

  connect() {
    console.log(`hello from controller`)
    console.log(this.element)
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

    fetch(event.target.href, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: dataBuilding(quizz_id)
    })
      .then(response => response.json())
      .then((data) => {
        console.log("data received")
        console.log(data)
        if (data.inserted_item) {
          console.log(this.element)
          console.log(data.inserted_item)
          const openned_modal = this.element.getElementsByClassName('modal show')
          console.log(openned_modal)
          console.log(openned_modal[0].getElementsByClassName('modal-body')[0])
          const modal_body = openned_modal[0].getElementsByClassName('modal-body')[0]
          modal_body.innerHTML = data.inserted_item
        }
      })
  }

}


const dataBuilding = (quizz_id) => {
  let payload = {
    type: "user_answer",
    quizz_id: quizz_id
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}
