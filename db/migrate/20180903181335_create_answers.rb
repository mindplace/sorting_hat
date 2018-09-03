class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :text, null: false
      t.integer :gryffindor, null: false
      t.integer :ravenclaw, null: false
      t.integer :hufflepuff, null: false
      t.integer :slytherin, null: false

      t.timestamps
    end
  end
end
