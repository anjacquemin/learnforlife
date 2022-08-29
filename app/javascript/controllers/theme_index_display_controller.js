import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["themeDiv", "leaderboardDiv","themeTab", "leaderboardTab"]

  connect() {
    console.log(`hello from controller`)
  }

  displayQuizzsDiv() {
    console.log("click detected")
    const theme_div = this.themeDivTarget
    const leaderboard_div = this.leaderboardDivTarget
    const theme_tab = this.themeTabTarget
    const leaderboard_tab = this.leaderboardTabTarget

    console.log(theme_div)
    console.log(theme_tab)
    console.log(leaderboard_div)
    console.log(leaderboard_tab)

    leaderboard_div.classList.toggle("d-none")
    leaderboard_tab.classList.toggle("active-tab")
    theme_div.classList.toggle("d-none")
    theme_tab.classList.toggle("active-tab")

  }

  cancelScroll(event) {
    event.preventDefault()
    console.log("click detect")
    console.log(event.target)
    fetch(event.target.href, {
      method: "GET",
      headers: {"Accept": "application/json"},
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.leaderboardDivTarget.innerHTML = data.inserted_item
        }
      })
    }

}
