class AddStudentIdtoJudgeCategories < ActiveRecord::Migration
  def change
  	add_reference :judge_categories, :student, index: true
  end
end
