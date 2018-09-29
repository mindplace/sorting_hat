# == Schema Information
#
# Table name: quiz_questions
#
#  id          :integer          not null, primary key
#  quiz_id     :integer          not null
#  question_id :integer          not null
#  answer_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuizQuestion < ApplicationRecord
  attr_accessor :possible_answers

  belongs_to :answer
  belongs_to :question

  belongs_to :quiz

  def text
    question.text
  end
end
