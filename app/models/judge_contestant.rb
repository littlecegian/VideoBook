class JudgeContestant < ActiveRecord::Base
  belongs_to :judge
  belongs_to :student
  
  def self.getContestant(judgeid)
      return JudgeContestant.where(judge_id: judgeid).pluck(:student_id)
  end
   
end
