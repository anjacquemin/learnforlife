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
          console.log(data.type)
          if (data["type"] === "ready_to_play") {
            this.displayTarget.classList.remove("d-none")
            this.waitingTarget.classList.add("d-none")
            this.themeChoiceTarget.classList.remove("d-none")
            this.playerToPlayTarget.innerHTML = `${data["player_to_play"]} choisis un thème`
          } else if (data["type"] === "quizz_begin"){
            this.playButtonTarget.value = "Play"
            console.log(this.playButtonTarget.parentElement)
            console.log(this.playButtonTarget.formAction)
            this.playButtonTarget.classList.remove("d-none")
            this.playButtonTarget.parentElement.action = `/duels/${data["duel_id"]}/duel_quizzs/${data["duel_quizz_id"]}/duel_quizz_questions`
          }
        }
      }
    )
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
