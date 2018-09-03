require 'csv'

class QuestionsAndAnswersPopulator
  def initialize(file_name:)
    @file_name = file_name
  end

  def perform
    persist_answers_and_questions
    puts "Answers and questions from '#{file_name}' are persisted to the DB."
  end

  private

  attr_reader :csv_data, :file_name

  def persist_answers_and_questions
    CSV.foreach(file_name, headers: true, header_converters: :symbol, quote_char: '"', force_quotes: true) do |row|
      data = row.to_h
      question = instantiate_question(question_data: data)
      instantiate_answer(question: question, answer_data: data)
    end
  end

  private

  def instantiate_question(question_data:)
    text = question_data.delete(:question)
    Question.find_or_create_by(text: text)
  end

  def instantiate_answer(question:, answer_data:)
    answer_data = answer_data.map { |k, v| k == :answer ? [:text, v] : [k, v.to_i] }.to_h
    Answer.find_or_create_by(answer_data.merge(question_id: question.id))
  end
end

namespace :db do
  namespace :seed do
    desc "Populate questions and answers from CSV."

    task answers: :environment do
      file_name = Rails.root.join('lib', 'files', 'answers.csv').to_s
      QuestionsAndAnswersPopulator.new(file_name: file_name).perform
    end
  end
end
