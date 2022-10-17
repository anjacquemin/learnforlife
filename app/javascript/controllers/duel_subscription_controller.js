import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { duelId: Number }
  static targets = ["display", "waiting", "themeChoice"]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "DuelChannel", id: this.duelIdValue },
      { received: data => {
        console.log(data.type)
        if (data["type"] === "ready_to_play") {
          this.displayTarget.classList.remove("d-none")
          this.waitingTarget.classList.add("d-none")
          this.themeChoiceTarget.classList.remove("d-none")
        }
          // handleData(data, this)
        }
      }
    )
  }
}
