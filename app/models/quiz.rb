class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, class_name: 'QuizQuestion'
  has_many :answers, through: :questions

  def instantiate_questions_and_answers
    Answer.all.group_by(:question_id).map do |answer_set|
      UserQuestion.new(possible_answers: answer_set, question: answer_set.first.question_id)
    end
  end
end
