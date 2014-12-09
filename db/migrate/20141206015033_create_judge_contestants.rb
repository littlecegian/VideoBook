class CreateJudgeContestants < ActiveRecord::Migration
  def change
    create_table :judge_contestants do |t|
      t.references :judge, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
