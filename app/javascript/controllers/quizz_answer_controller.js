// src/controllers/disable_button_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["userAnswer", "questionId", "questionCard0","questionCard1", "questionCard2", "questionCard3", "questionCard4", "cardCountBar", "cardCountNumber", "answer1", "answer2", "seconds", "tens"]


  connect() {
    console.log("Hello from our first Stimulus controller")
    window.seconds = 0;
    window.tens = 0;
    window.appendTens = this.tensTarget;
    window.appendSeconds = this.secondsTarget;
    var Interval
    clearInterval(Interval);
    Interval = setInterval(startTimer, 10);
  }

  checkAnswer(event) {
    console.log("click")

    // To handle when a user click on the text of the answer and not the div
    var corrected_target = event.target.hasAttribute("data-user-answer-id") ? event.target : event.target.parentElement

    //disable click on all answers
    Array.from(corrected_target.parentElement.children).forEach(answer => answer.dataset.action = " ")

    //Enable to cancel click on the answer, so the purple color triggered by hovering disappear
    corrected_target.style.pointerEvents = "none"

    const user_answer = corrected_target.dataset.userAnswerId
    const good_answer = corrected_target.parentElement.dataset.goodAnswerId
    const question_id = corrected_target.parentElement.dataset.questionId
    const question_number = parseInt(corrected_target.parentElement.dataset.questionNumber)
    const next_question_number = parseInt(question_number) + 1
    const total_questions = corrected_target.parentElement.dataset.totalQuestions


    this.cardCountBarTarget.style.width = `${((question_number + 1)/total_questions)*100}%`
    this.cardCountNumberTarget.innerHTML = `${(parseInt(question_number) + 1)}/${total_questions}`

    if (user_answer === good_answer){
        corrected_target.classList.add("green-background")
    } else {
        corrected_target.classList.add("red-background")
    }

    const self = this

    delay(2000).then(() => {
      eval(`self.questionCard${question_number}Target.classList.add("d-none")`)
      eval(`self.questionCard${next_question_number}Target.classList.remove("d-none")`)
    });
  }
}


function delay(time) {
  return new Promise(resolve => setTimeout(resolve, time));
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
    console.log("seconds");
    seconds++;
    appendSeconds.innerHTML = "0" + seconds;
    tens = 0;
    appendTens.innerHTML = "0" + 0;
  }

  if (self.seconds > 9){
    self.appendSeconds.innerHTML = seconds;
  }
}
