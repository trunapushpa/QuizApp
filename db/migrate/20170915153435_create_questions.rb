class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :subgenre, foreign_key: true
      t.text :description
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :option4
      t.boolean :correct1
      t.boolean :correct2
      t.boolean :correct3
      t.boolean :correct4

      t.timestamps
    end
  end
end
