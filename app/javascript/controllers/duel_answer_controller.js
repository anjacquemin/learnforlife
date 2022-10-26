import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["questionDiv", "goodAnswer", "form", "endButtonDisplay", "endButton", "seconds", "tens"]

  connect() {
    console.log("duel answer controller")
    console.log("ici")

    window.Interval
    clearInterval(window.Interval);

    // if the user leave the quizz and then come back, only call 1 time setInterval
    var counter_page_loaded = parseInt(this.element.dataset.stimulusConnectCount);
    console.log(counter_page_loaded)

    counter_page_loaded ++;
    this.element.dataset.stimulusConnectCount = counter_page_loaded

    const quizz_level = this.element.dataset.quizzLevel

    if(quizz_level === "Difficile"){
      this.form0Target.parentElement.parentElement.children[1].children[0].focus()
    }

    if (counter_page_loaded === 1) {
      window.seconds = 0;
      window.tens = 0;
      console.log("UPDATE VIEW")
      window.appendTens = this.tensTarget;
      window.appendSeconds = this.secondsTarget;
      window.Interval = setInterval(startTimer, 10);
      if (window.appendSeconds < 0) {
        // DO STG + REDIRECTION
        // if difficile, send current result, else send no answer
      }

    } else {
      // if back and force on the page, set all the value to their value
      window.seconds = parseInt(this.secondsTarget.innerHTML);
      window.tens = parseInt(this.tensTarget.innerHTML);
      window.appendTens = this.tensTarget;
      window.appendSeconds = this.secondsTarget;
      console.log("UPDATE VIEW")
      console.log(window.appendSeconds)
    }
  }

  difficultyChoice(event) {
    console.log("click detection in difficulty choice")

    event.preventDefault()

    console.log("Click detection")
    console.log(event.currentTarget.dataset)
    const difficulty_choice = event.currentTarget.dataset.difficultyChoice
    console.log(this.element.dataset.url)
    const url = this.element.dataset.url
    const duel_quizz_question_id = this.element.dataset.quizzQuestionId
    console.log(duel_quizz_question_id)
    console.log(difficulty_choice)
    const data = difficultyDataBuilding(difficulty_choice, duel_quizz_question_id)

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: data
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      this.questionDivTarget.innerHTML=data.inserted_item
    })
  }

  checkAnswer(event) {
    console.log("click detection in checkanswer choice")

    event.preventDefault()

    //disable click on all answers
    Array.from(event.currentTarget.parentElement.children).forEach(answer => answer.dataset.action = " ")
    event.currentTarget.style.pointerEvents = "none"
    event.currentTarget.style.touchAction = "none"

    const difficulty = event.currentTarget.parentElement.dataset.difficulty
    const question_id = event.currentTarget.parentElement.dataset.questionId
    const duel_answer_id = event.currentTarget.parentElement.dataset.duelAnswerId;
    const answer_url = event.currentTarget.parentElement.dataset.answerUrl;
    const duel_quizz_id = event.currentTarget.parentElement.dataset.duelQuizzId;
    const duel_quizz_questions_url = event.currentTarget.parentElement.dataset.duelQuizzQuestionsUrl;

    console.log(`diifculty ${difficulty}`)
    console.log(`question_id ${question_id}`)
    console.log(`duel_answer_id ${duel_answer_id}`)
    console.log(`answer_url ${answer_url}`)

    self = this

    if(difficulty === "Facile" || difficulty === "Moyen"){
      const user_answer = event.currentTarget.childNodes[1].innerHTML
      const data = answerDataBuilding(question_id, duel_answer_id, user_answer)

      fetch(answer_url, {
        method: "PATCH",
        headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
        body: data
      })
      .then(response => response.json())
      .then((data) => {
        if (data.is_good_answer === true){
          event.currentTarget.classList.add("green-background")
          // good_answer_count_target.innerHTML = parseInt(good_answer_count_target.innerHTML) + 1
        } else {
          // bad_answer_count_target.innerHTML = parseInt(bad_answer_count_target.innerHTML) + 1
          event.currentTarget.classList.add("red-background")
          self.goodAnswerTargets.forEach ((answerTarget) => {
            if (answerTarget.childNodes[1].innerHTML === data.good_answer){
              answerTarget.classList.add("green-background")
            }
          })
        }
      })

    }

    delay(100).then(() => {
      console.log(duel_quizz_questions_url)
      fetch(duel_quizz_questions_url, {
        method: "GET",
        headers: { "Accept": "application/json" },
      })
      .then(response => response.json())
      .then((data) => {
        // if end of the duel quizz
        console.log("Get answer controller")
        console.log(data)
        console.log(data.end)
        if (data.end) {
          this.endButtonDisplayTarget.insertAdjacentHTML("beforeend", data.end)
          this.endButtonTarget.click()
        } else {
          this.element.innerHTML=data.inserted_item
        }
      })
    });
  }
}

const difficultyDataBuilding = (difficulty_choice, duel_quizz_question_id) => {
  let payload = {
    type: "difficulty_choice",
    difficulty_choice: difficulty_choice,
    duel_quizz_question_id: duel_quizz_question_id,
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
}

const answerDataBuilding = (question_id, duel_answer_id, user_answer) => {
  let payload = {
    type: "user_answer",
    question_id: question_id,
    duel_answer_id: duel_answer_id,
    user_answer: user_answer
  }

  let data = new FormData();
  data.append ("json", JSON.stringify(payload))

  return data
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
    appendSeconds.innerHTML = 9 - seconds;
    tens = 0;
  }
}
