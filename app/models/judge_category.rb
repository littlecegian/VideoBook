class JudgeCategory < ActiveRecord::Base
  belongs_to :Judge
  belongs_to :Category

  def self.getpreferredcategories(judgeid)
  		return JudgeCategory.where(judge_id: judgeid).pluck(:category_id)
  end
end
