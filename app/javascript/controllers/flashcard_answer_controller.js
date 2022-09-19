import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  // number of circle target = number of themes
  static targets = ["endButton", "cardCountBar", "cardCountNumber", "seconds", "tens"]

  connect() {
    console.log(`hello from controller`)

    // window.Interval
    // clearInterval(window.Interval);

    // if the user leave the quizz and then come back, only call 1 time setInterval
    // var counter_page_loaded = parseInt(this.element.dataset.stimulusConnectCount);
    // counter_page_loaded ++;
    // this.element.dataset.stimulusConnectCount = counter_page_loaded

    // if (counter_page_loaded === 1) {
    //   console.log("fisrt time connected")
    //   window.seconds = 0;
    //   window.tens = 0;
    //   window.appendTens = this.tensTarget;
    //   window.appendSeconds = this.secondsTarget;
    //   window.Interval = setInterval(startTimer, 10);
    // } else {
    //   // if back and force on the page, set all the value to their value
    //   window.seconds = parseInt(this.secondsTarget.innerHTML);
    //   window.tens = parseInt(this.tensTarget.innerHTML);
    //   window.appendTens = this.tensTarget;
    //   window.appendSeconds = this.secondsTarget;
    // }
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

    const auto_eval = event.target.dataset.autoEvaluation
    const flashcard_id = event.target.parentElement.dataset.flashcardId
    const url = event.target.parentElement.dataset.url

    const number_of_card_to_display = this.element.dataset.flashcardsToDisplayCount
    console.log(auto_eval)
    console.log(flashcard_id)

    let flashcards_count = this.element.dataset.flashcardsCount
    const flashcards_total_count = this.element.dataset.flashcardsTotalCount


    const data = answerDataBuilding(flashcard_id, auto_eval, number_of_card_to_display)

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: data
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      console.log(data["show_again"])
      if (data.show_again){
        console.log("insert")
        const container = this.element.querySelector(".container")
        console.log(container)
        container.insertAdjacentHTML("beforeend",data["inserted_item"])
        this.element.dataset.flashcardsToDisplayCount = parseInt(number_of_card_to_display) + 1
        current_question.classList.add("d-none")
        const next_question = this.element.querySelector(`.questionCard${parseInt(question_card_count) + 1}`)
        console.log("Next question :")
        console.log(next_question)
        next_question.classList.remove("d-none")
      } else {
        // check if there is no flashcard left
        if (this.element.dataset.flashcardsToDisplayCount <= parseInt(question_card_count) + 1) {
          console.log('----------------------------------')
          console.log(this.endButtonTarget)
          this.endButtonTarget.click()
        } else {
          current_question.classList.add("d-none")
          const next_question = this.element.querySelector(`.questionCard${parseInt(question_card_count) + 1}`)
          console.log("Next question :")
          console.log(next_question)
          next_question.classList.remove("d-none")

          flashcards_count = parseInt(flashcards_count) + 1
          console.log(`cardcout ${flashcards_count}`)
          console.log(`total ${flashcards_total_count}`)

          this.cardCountBarTarget.style.width = `${((flashcards_count)/flashcards_total_count)*100}%`
          this.cardCountNumberTarget.innerHTML = `${(parseInt(flashcards_count))}/${parseInt(flashcards_total_count)}`
          this.element.dataset.flashcardsCount = flashcards_count


        }
      }
    })
  }
}


const answerDataBuilding = (flashcard_id, auto_eval, number_of_card_to_display) => {
  let payload = {
    type: "auto_eval",
    flashcard_id: flashcard_id,
    auto_eval: auto_eval,
    number_of_card_to_display: number_of_card_to_display
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
