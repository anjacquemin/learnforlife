import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


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

    const auto_eval = event.target.dataset.autoEvaluation
    const flashcard_id = event.target.parentElement.dataset.flashcardId
    const url = event.target.parentElement.dataset.url

    console.log(auto_eval)
    console.log(flashcard_id)

    const data = answerDataBuilding(auto_eval, flashcard_id)

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: data
    })
    .then(response => response.json())
    .then((data) => {
      if (data.is_good_answer == true){
        console.log(data)
      } else {
        console.log(data)
      }
    })



  }

}


const answerDataBuilding = (flashcard_id, auto_eval) => {
  let payload = {
    type: "auto_eval",
    flashcard_id: flashcard_id,
    auto_eval: auto_eval,
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}


function startTimer() {
  tens++;


  if(tens <= 9){
    // appendTens.innerHTML = "0" + tens;
  }

  if (tens > 9){
    // appendTens.innerHTML = tens;

  }

  if (tens > 99) {
    // console.log("seconds");
    seconds++;
    appendSeconds.innerHTML = "0" + seconds;
    tens = 0;
    appendTens.innerHTML = "0" + 0;
  }

  if (self.seconds > 9){
    self.appendSeconds.innerHTML = seconds;
  }
}
