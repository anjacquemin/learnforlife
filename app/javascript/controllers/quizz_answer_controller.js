// src/controllers/disable_button_controller.js

import { Controller } from "@hotwired/stimulus"
import { goodAnswerTargets } from "./_good_answer_targets_constant.js"
import {questionTargets} from  "./_question_targets_constant.js"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  static targets = ["userAnswer", "questionId", "cardCountBar", "cardCountNumber", "seconds", "tens", "goodAnswer", "endButtonDisplay", "endButton"].concat(questionTargets).concat(goodAnswerTargets)

  connect() {
    console.log("Hello from our first Stimulus controller")

    window.Interval
    clearInterval(window.Interval);

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
      window.Interval = setInterval(startTimer, 10);
    } else {
      // if back and force on the page, set all the value to their value
      window.seconds = parseInt(this.secondsTarget.innerHTML);
      window.tens = parseInt(this.tensTarget.innerHTML);
      window.appendTens = this.tensTarget;
      window.appendSeconds = this.secondsTarget;
    }
  }

  checkAnswer(event) {
    event.preventDefault()

    console.log("click")


    // To handle when a user click on the text of the answer and not the div
    var corrected_target = event.target.hasAttribute("data-user-answer-id") ? event.target : event.target.parentElement

    //disable click on all answers
    Array.from(corrected_target.parentElement.children).forEach(answer => answer.dataset.action = " ")

    //Enable to cancel click on the answer, so the purple color triggered by hovering disappear
    corrected_target.style.pointerEvents = "none"

    const user_answer_id = corrected_target.dataset.userAnswerId
    const user_answer = corrected_target.dataset.userAnswer
    const good_answer = corrected_target.parentElement.dataset.goodAnswerId
    const question_id = corrected_target.parentElement.dataset.questionId
    const question_number = parseInt(corrected_target.parentElement.dataset.questionNumber)
    const next_question_number = parseInt(question_number) + 1
    const total_questions = corrected_target.parentElement.dataset.totalQuestions;

    const quizz_answer_id = corrected_target.parentElement.dataset.quizzAnswerId;
    const answer_url = corrected_target.parentElement.dataset.answerUrl;
    const record_url = corrected_target.parentElement.dataset.recordUrl;
    console.log(`quizz answer id ${quizz_answer_id}`)


    this.cardCountBarTarget.style.width = `${((question_number + 1)/total_questions)*100}%`
    this.cardCountNumberTarget.innerHTML = `${(parseInt(question_number) + 1)}/${total_questions}`

    // handle last question
      if (next_question_number == total_questions) {
        clearInterval(Interval);
      }

    const data = answerDataBuilding(user_answer_id, question_id, quizz_answer_id, user_answer)
    console.log(`url: ${answer_url} `)
    fetch(`${answer_url}`, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: data
    })


    if (user_answer_id === good_answer){
        corrected_target.classList.add("green-background")
    } else {
        corrected_target.classList.add("red-background")
        eval(`this.goodAnswer${question_number}Target.classList.add("green-background")`)
    }

    const self = this

    console.log(`next_question_number${next_question_number} && total question ${total_questions}`)

    delay(100).then(() => {
      if(next_question_number < total_questions){
        eval(`self.questionCard${question_number}Target.classList.add("d-none")`)
        eval(`self.questionCard${next_question_number}Target.classList.remove("d-none")`)
      } else if (question_number < total_questions) {
        console.log("send end quizz data")
        const data = endQuizzBuilding(quizz_answer_id)
        fetch(`${record_url}`, {
          method: "POST",
          headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
          body: data
        })
        .then(response => response.json())
        .then((data) => {
          if (data.inserted_item){
            console.log(data)
            console.log(data.inserted_item)
            // even for last answer, d-none the div, to avoid to see it, if the quizz is redone
            eval(`self.questionCard${question_number}Target.classList.add("d-none")`)
            this.endButtonDisplayTarget.insertAdjacentHTML("beforeend", data.inserted_item)
            this.endButtonTarget.click()
          }
        })
      }
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


const answerDataBuilding = (user_answer_id, question_id, quizz_answer_id, user_answer) => {
  let payload = {
    type: "user_answer",
    question_id: question_id,
    user_answer_id: user_answer_id,
    user_answer: user_answer,
    quizz_answer_id: quizz_answer_id
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}

const endQuizzBuilding = (quizz_answer_id) => {
  let payload = {
    type: "user_answer",
    final_time_seconds: seconds,
    final_time_tens: tens,
    quizz_answer_id: quizz_answer_id
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}
