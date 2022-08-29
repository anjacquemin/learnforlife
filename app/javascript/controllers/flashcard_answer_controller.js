import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // number of circle target = number of themes
  static targets = []

  connect() {
    console.log(`hello from controller`)
  }

  seeAnswer(event) {
    console.log("click detected")

    const question_div = event.target.closest(".questions")
    console.log(question_div)
    const flashcard_answer = question_div.querySelector(".flashcard-answer")
    const auto_evaluation_buttons = question_div.querySelector(".auto-evaluation-buttons")

    console.log(flashcard_answer)
    console.log(auto_evaluation_buttons)


    flashcard_answer.classList.remove("d-none")
    auto_evaluation_buttons.classList.remove("d-none")
    event.target.classList.add("d-none")


  }

  autoEvaluation(event) {
    const question_card_count = event.target.parentElement.dataset.questionCardCount
    console.log(question_card_count)

    const current_question = event.target.closest(`.questionCard${question_card_count}`)
    console.log(`.questionCard${question_card_count}`)
    console.log(current_question)
    current_question.classList.add("d-none")

    const next_question = this.element.querySelector(`.questionCard${parseInt(question_card_count + 1)}`)
    next_question.classList.remove("d-none")

  }

}
