# == Schema Information
#
# Table name: quiz_questions
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  question_id :integer          not null
#  answer_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuizQuestion < ApplicationRecord
  attr_accessor :possible_answers
  has_one :answer
  has_one :question

  belongs_to :quiz
end
