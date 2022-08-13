// src/controllers/disable_button_controller.js

import { Controller } from "@hotwired/stimulus"
import {questionTargets} from  "./_question_targets_constant.js"


export default class extends Controller {

  static targets = ["userAnswer", "questionId", "cardCountBar", "cardCountNumber", "answer1", "answer2", "seconds", "tens"].concat(questionTargets)

  connect() {
    console.log("Hello from our first Stimulus controller")

    var Interval
    clearInterval(Interval);

    // if the user leave the quizz and then come back, only call 1 time setInterval
    var counter_page_loaded = parseInt(this.element.dataset.stimulusConnectCount);
    counter_page_loaded ++;
    this.element.dataset.stimulusConnectCount = counter_page_loaded

    if (counter_page_loaded === 1) {
      console.log("fisrt time connected")
      window.seconds = 0;
      window.tens = 0;
      window.appendTens = this.tensTarget;
      window.appendSeconds = this.secondsTarget;
      Interval = setInterval(startTimer, 10);
    } else {
      // if back and force on the page, set all the value to their value
      window.seconds = parseInt(this.secondsTarget.innerHTML);
      window.tens = parseInt(this.tensTarget.innerHTML);
      window.appendTens = this.tensTarget;
      window.appendSeconds = this.secondsTarget;
    }
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

    delay(1000).then(() => {
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
