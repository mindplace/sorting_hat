class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
