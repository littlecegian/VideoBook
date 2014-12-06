class JudgeContestant < ActiveRecord::Base
  belongs_to :judge
  belongs_to :student
end
