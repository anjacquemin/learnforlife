// src/controllers/disable_button_controller.js

import { Controller } from "@hotwired/stimulus"
import { formTargets } from  "./_form_targets_constant.js"
import { questionTargets } from  "./_question_targets_constant.js"
import { goodAnswerTargets } from "./_good_answer_targets_constant.js"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {

  static targets = ["userAnswer", "questionId", "cardCountBar", "cardCountNumber", "seconds", "tens", "goodAnswer", "endButtonDisplay", "endButton", "goodAnswerCount", "badAnswerCount"].concat(questionTargets).concat(goodAnswerTargets).concat(formTargets)

  connect() {
    window.Interval
    clearInterval(window.Interval);

    // if the user leave the quizz and then come back, only call 1 time setInterval
    var counter_page_loaded = parseInt(this.element.dataset.stimulusConnectCount);
    counter_page_loaded ++;
    this.element.dataset.stimulusConnectCount = counter_page_loaded



    if (counter_page_loaded === 1) {
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

    // To handle when a user click on the text of the answer and not the div
    var corrected_target = event.target.hasAttribute("data-user-answer-id") ? event.target : event.target.parentElement



    //disable click on all answers
    Array.from(corrected_target.parentElement.children).forEach(answer => answer.dataset.action = " ")

    //Enable to cancel click on the answer, so the purple color triggered by hovering disappear
    corrected_target.style.pointerEvents = "none"

    const quizz_level = corrected_target.parentElement.dataset.quizzLevel
    const question_id = corrected_target.parentElement.dataset.questionId
    const question_number = parseInt(corrected_target.parentElement.dataset.questionNumber)
    const next_question_number = parseInt(question_number) + 1
    const total_questions = corrected_target.parentElement.dataset.totalQuestions;
    const quizz_answer_id = corrected_target.parentElement.dataset.quizzAnswerId;
    const answer_url = corrected_target.parentElement.dataset.answerUrl;
    const record_url = corrected_target.parentElement.dataset.recordUrl;
    const good_answer_count_target = this.goodAnswerCountTarget
    const bad_answer_count_target = this.badAnswerCountTarget

    this.cardCountBarTarget.style.width = `${((question_number + 1)/total_questions)*100}%`
    this.cardCountNumberTarget.innerHTML = `${(parseInt(question_number) + 1)}/${total_questions}`

    // handle last question
    if (next_question_number == total_questions) {
      clearInterval(Interval);
    }

    const self = this

    if(quizz_level === "Facile" || quizz_level === "Moyen"){
      const user_answer_id = corrected_target.dataset.userAnswerId
      const user_answer = corrected_target.dataset.userAnswer
      const data = answerDataBuilding(user_answer_id, question_id, quizz_answer_id, user_answer, quizz_level)

      fetch(`${answer_url}`, {
        method: "POST",
        headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
        body: data
      })
      .then(response => response.json())
      .then((data) => {
        if (data.is_good_answer === true){
          corrected_target.classList.add("green-background")
          good_answer_count_target.innerHTML = parseInt(good_answer_count_target.innerHTML) + 1
        } else {
          bad_answer_count_target.innerHTML = parseInt(bad_answer_count_target.innerHTML) + 1
          corrected_target.classList.add("red-background")
          const answers_targets = eval(`self.goodAnswer${question_number}Targets`)
          answers_targets.forEach ((answerTarget) => {
            if (answerTarget.childNodes[1].innerHTML === data.good_answer){
              answerTarget.classList.add("green-background")
            }
          })
        }
      })
    }

    if(quizz_level === "Difficile"){
      const user_answer = eval(`this.form${question_number}Target.value`)
      const data = answerDataBuildingForDifficultLevel(question_id, quizz_answer_id, user_answer, quizz_level)
      const self = this

      // Remove focus from input field, so background color can be updated
      eval(`this.form${question_number}Target.blur()`)
      // https://stackoverflow.com/questions/31578094/ruby-on-rails-simple-form-text-field-value-is-overridden-by-default-value
      // https://stackoverflow.com/questions/11340843/default-disable-with-for-simple-form-submit

      event.target.children[2].value = "Valider"

      fetch(`${answer_url}`, {
        method: "POST",
        headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
        body: data
      })
      .then(response => response.json())
      .then((data) => {
        if (data.is_good_answer == true){
          good_answer_count_target.innerHTML = parseInt(good_answer_count_target.innerHTML) + 1
          eval(`self.form${question_number}Target.classList.add("green-background")`)
        } else {
          bad_answer_count_target.innerHTML = parseInt(bad_answer_count_target.innerHTML) + 1
          eval(`self.form${question_number}Target.classList.add("red-background")`)
        }
      })
    }

    delay(800).then(() => {
      if(next_question_number < total_questions){
        eval(`self.questionCard${question_number}Target.classList.add("d-none")`)
        eval(`self.questionCard${next_question_number}Target.classList.remove("d-none")`)
        if (quizz_level == "Difficile") {
          eval(`self.form${next_question_number}Target.parentElement.parentElement.children[1].children[0].focus()`)
        }
      } else if (question_number < total_questions) {
        const data = endQuizzBuilding(quizz_answer_id)
        fetch(`${record_url}`, {
          method: "POST",
          headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
          body: data
        })
        .then(response => response.json())
        .then((data) => {
          // handle the case when the answers are not valid (not enough answer or time < minimum time)
          if (data.location) {
            window.location = data.location;
          }
          if (data.inserted_item){
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
    seconds++;
    appendSeconds.innerHTML = "0" + seconds;
    tens = 0;
    appendTens.innerHTML = "0" + 0;
  }

  if (self.seconds > 9){
    self.appendSeconds.innerHTML = seconds;
  }
}


const answerDataBuilding = (user_answer_id, question_id, quizz_answer_id, user_answer, quizz_level) => {
  let payload = {
    type: "user_answer",
    question_id: question_id,
    user_answer_id: user_answer_id,
    user_answer: user_answer,
    quizz_answer_id: quizz_answer_id,
    quizz_level: quizz_level
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}

const answerDataBuildingForDifficultLevel = (question_id, quizz_answer_id, user_answer, quizz_level) => {
  let payload = {
    type: "user_answer",
    question_id: question_id,
    user_answer: user_answer,
    quizz_answer_id: quizz_answer_id,
    quizz_level: quizz_level
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
