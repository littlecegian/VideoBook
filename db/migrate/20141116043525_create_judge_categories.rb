class CreateJudgeCategories < ActiveRecord::Migration
  def change
    create_table :judge_categories do |t|
      t.references :judge, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
