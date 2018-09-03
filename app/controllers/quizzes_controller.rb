class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
    @quiz.instantiate_questions_and_answers
  end

  def create
    current_user.quizzes.build(quiz_params)
    binding.pry
  end

  def quiz_params
    params.require(:quiz).permit(questions: [:question_id, :answer_id])
  end
end
