import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"

import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { duelId: Number }
  static targets = ["display", "waiting", "themeChoice", "playButton", "playerToPlay", "themeChoiceButton"]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "DuelChannel", id: this.duelIdValue },
      { received: data => {
          console.log(data)
          if (data["type"] === "ready_to_play") {
            fetch(data["url"], {
              method: "GET",
              headers: { "Accept": "application/json"},
            })
            .then(response => response.json())
            .then((data) => {
              console.log(data.inserted_item)
              this.element.innerHTML = data.inserted_item
            })
            // this.playButtonTarget.classList.remove("d-none")
          } else if (data["type"] === "quizz_begin"){
            fetch(data["url"], {
              method: "GET",
              headers: { "Accept": "application/json"},
            })
            .then(response => response.json())
            .then((data) => {
              console.log(data.inserted_item)
              this.element.innerHTML = data.inserted_item
            })
          } else if (data["type"] === "end_quizz"){
            fetch(data["url"], {
              method: "GET",
              headers: { "Accept": "application/json"},
            })
            .then(response => response.json())
            .then((data) => {
              console.log(data.inserted_item)
              this.element.innerHTML = data.inserted_item
              // DISPLAY MODAL WITH RESULTS + BONUS POINTS SI TOUT JUSTE (+ 20%)
            })
          }
        }
      }
    )
  }

  showThemeChoice(event) {
    this.themeChoiceTarget.classList.remove("d-none")
  }

  themeChoice(event) {

    event.preventDefault()

    console.log("Click detection")
    console.log(event.target.dataset)
    const theme_id = event.target.dataset.themeId
    const url = event.target.dataset.url
    const data = answerDataBuilding(theme_id)

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: data
    })
    .then(response => response.json())
  }

}

const answerDataBuilding = (theme_id) => {
  let payload = {
    type: "theme_choice",
    theme_id: theme_id,
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}
