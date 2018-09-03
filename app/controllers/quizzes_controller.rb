class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
    @quiz.instantiate_questions_and_answers
  end

  def create
    binding.pry
    current_user.quizzes.build(quiz_params)
  end

  def quiz_params
    params.require(:quiz).permit(questions: [:question_id, :answer_id])
  end
end
