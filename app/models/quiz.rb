# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quiz < ApplicationRecord
  HOUSES = [:gryffindor, :ravenclaw, :hufflepuff, :slytherin].freeze
  USER_CHOICE_WEIGHT = 200

  belongs_to :user
  has_many :questions, class_name: 'QuizQuestion'
  has_many :answers, through: :questions

  attr_accessor :gryffindor_score, :ravenclaw_score, :hufflepuff_score, :slytherin_score

  after_initialize :instantiate_initial_weights

  def instantiate_questions_and_answers
    Answer.all.group_by(&:question_id).map do |question_id, answer_set|
      next if questions.any? { |q| q.question_id == question_id } # don't create multiples of same question if exists
      questions.find_or_initialize_by(possible_answers: answer_set, question_id: question_id)
    end
  end

  def score
    @score ||= score_answers
  end

  private

  def instantiate_initial_weights
    HOUSES.each { |house| self.send("#{house}_score=", 0) }
  end

  def score_answers
    build_answers_counters
    add_user_choice
    fetch_strongest_answer
  end

  def build_answers_counter
    answers_counter = answers.as_json(only: [:gryffindor, :ravenclaw, :hufflepuff, :slytherin])
    answers_counter = answers_counter.inject { |a, b| a.merge(b) { |_,x,y| x + y } }
    answers_counter.each { |set| HOUSES.each { |house| self.send("#{house}_score=", set[house]) } }
  end

  def add_user_choice
    current_count = self.send("#{user.house_choice}_counter")
    self.send("#{user.house_choice}_counter=", current_count + USER_CHOICE_WEIGHT)
  end

  def fetch_strongest_answer
    HOUSES.map { |house| [house, self.send("#{house}_counter")] }.to_h.max_by { |k, v| v }.key
  end
end
