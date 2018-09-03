class CreateQuizQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_questions do |t|
      t.integer :quiz_id, null: false

      t.integer :question_id, null: false
      t.integer :answer_id, null: false

      t.timestamps
    end
  end
end
