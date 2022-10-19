import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["questionDiv", "goodAnswer", "form", "endButtonDisplay", "endButton"]

  connect() {
    console.log("duel answer controller")
    console.log("ici")
  }

  difficultyChoice(event) {
    console.log("click detection in difficulty choice")

    event.preventDefault()

    console.log("Click detection")
    console.log(event.target.dataset)
    const difficulty_choice = event.target.dataset.difficultyChoice
    console.log(this.element.dataset.url)
    const url = this.element.dataset.url
    const duel_quizz_question_id = this.questionDivTarget.dataset.quizzQuestionId
    console.log(duel_quizz_question_id)
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

    // To handle when a user click on the text of the answer and not the div
    var corrected_target = event.target.hasAttribute("data-quizz-answer-target") ? event.target : event.target.parentElement

    //disable click on all answers
    Array.from(corrected_target.parentElement.children).forEach(answer => answer.dataset.action = " ")
    corrected_target.style.pointerEvents = "none"
    corrected_target.style.touchAction = "none"

    const difficulty = corrected_target.parentElement.dataset.difficulty
    const question_id = corrected_target.parentElement.dataset.questionId
    const duel_answer_id = corrected_target.parentElement.dataset.duelAnswerId;
    const answer_url = corrected_target.parentElement.dataset.answerUrl;
    const duel_quizz_id = corrected_target.parentElement.dataset.duelQuizzId;
    const duel_quizz_questions_url = corrected_target.parentElement.dataset.duelQuizzQuestionsUrl;

    console.log(`diifculty ${difficulty}`)
    console.log(`question_id ${question_id}`)
    console.log(`duel_answer_id ${duel_answer_id}`)
    console.log(`answer_url ${answer_url}`)

    self = this

    if(difficulty === "easy" || difficulty === "medium"){
      const user_answer = corrected_target.childNodes[1].innerHTML
      const data = answerDataBuilding(question_id, duel_answer_id, user_answer)

      fetch(answer_url, {
        method: "PATCH",
        headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
        body: data
      })
      .then(response => response.json())
      .then((data) => {
        if (data.is_good_answer === true){
          corrected_target.classList.add("green-background")
          // good_answer_count_target.innerHTML = parseInt(good_answer_count_target.innerHTML) + 1
        } else {
          // bad_answer_count_target.innerHTML = parseInt(bad_answer_count_target.innerHTML) + 1
          corrected_target.classList.add("red-background")
          self.goodAnswerTargets.forEach ((answerTarget) => {
            if (answerTarget.childNodes[1].innerHTML === data.good_answer){
              answerTarget.classList.add("green-background")
            }
          })
        }
      })
    }

    delay(1000).then(() => {
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
