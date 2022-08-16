class RecordsController < ApplicationController

  def show
    @record = Record.find(params[:id])

    quizz_answer_id = @record.quizz_answer_id
    user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id)

    @synthesis = []

    @synthesis = user_answers.map do |user_answer|
      question_synthesis = { question: "", answer: "", user_answer: "", is_answer_good: false }

      question_answer = user_answer.question_answer

      question_synthesis[:question] = question_answer.question
      question_synthesis[:answer] = question_answer.answer
      question_synthesis[:user_answer]= user_answer.answer
      question_synthesis[:is_good] = true if user_answer.answer_id == question_answer.id

      question_synthesis
    end

    #take all records from the user
    #check if new record

  end

  def create
    user = current_user
    data = JSON.parse(params["json"])

    puts ("received data in method crete/records : #{data}")

    time_seconds = data["final_time_seconds"]
    time_tens = data["final_time_tens"]
    quizz_answer_id = data["quizz_answer_id"].to_i

    user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id)

    good_answer_count = 0
    bad_answer_count = 0
    synthesis = []

    synthesis = user_answers.map do |user_answer|
      current_question_answer = user_answer.question_answer
      answer = user_answer.answer

      if user_answer.answer_id == current_question_answer.id
        good_answer_count += 1
      else
        bad_answer_count += 1
      end
    end

    # BACK END CHECK NUMBER OF ANSWER = NUMBER OF QUESTION + TIME  (time_difference_in_milliseconds?)
    score_percentage = ((good_answer_count - bad_answer_count) / (good_answer_count + bad_answer_count))

    quizz_seconds_duration = data["final_time_seconds"]
    quizz_milliseconds_duration = data["final_time_tens"]

    quizz_level = QuizzAnswer.find(quizz_answer_id).quizz_level

    @record = Record.new(user: current_user, quizz_level: quizz_level, seconds_duration: quizz_seconds_duration, milliseconds_duration: quizz_milliseconds_duration, score_percentage: score_percentage, quizz_answer_id: quizz_answer_id)

    # TO BE CHANGED
    @record.crown_or_sphere = "crown"
    @record.completion = 2

    @record.save!

    respond_to do |format|
      format.json
    end

  end
end