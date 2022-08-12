// src/controllers/disable_button_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["goodAnswer", "userAnswer", "questionId", "questionCard0","questionCard1", "questionCard2", "questionCard3", "questionCard4"]


  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  checkAnswer(event) {
    console.log("click")
    // console.log(`question target`)
    // console.log(this.questionTarget)
    // console.log(this.questionTarget.dataset.answerId)
    // console.log(`user answer target`)

    // To handle when a user click on the text of the answer and not the div

    console.log(event.target)
    console.log(event.target.parentElement)
    var user_answer = ""
    var text_has_been_clicked
    // console.log(this.userAnswerTarget.dataset.userAnswerId)
    // const user_answer = this.userAnswerTarget.dataset.userAnswerId
    if (!(event.target.hasAttribute("data-user-answer-id"))) {
      text_has_been_clicked = true
      user_answer = event.target.parentElement.dataset.userAnswerId
    }else {
      user_answer = event.target.dataset.userAnswerId
      console.log(`user answer : ` + user_answer)
    }

    const good_answer = this.goodAnswerTarget.dataset.goodAnswerId
    const question_id = this.goodAnswerTarget.dataset.questionId
    const next_question_id = parseInt(question_id) + 1

    console.log(question_id)
    console.log(next_question_id)
    if (user_answer === good_answer){
      // console.log(`bonne reponse`)
      // console.log(this.userAnswerTarget)
      if (text_has_been_clicked) {
        event.target.parentElement.classList.add("green-background")
      } else{
        event.target.classList.add("green-background")
      }
    } else {
      if (text_has_been_clicked) {
        event.target.parentElement.classList.add("red-background")
      } else{
        event.target.classList.add("red-background")
      }
    }

    const self = this

    delay(1000).then(() => {
      // console.log('ran after 1 second1 passed')
      eval(`self.questionCard${parseInt(question_id)}Target.classList.add("d-none")`)
      eval(`self.questionCard${next_question_id}Target.classList.remove("d-none")`)
    });
  }
}


function delay(time) {
  return new Promise(resolve => setTimeout(resolve, time));
}
