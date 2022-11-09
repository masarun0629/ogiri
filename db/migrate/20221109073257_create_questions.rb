class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text       :question, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
