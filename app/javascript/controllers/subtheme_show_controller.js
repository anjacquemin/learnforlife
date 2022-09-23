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
