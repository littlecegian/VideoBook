class JudgeCategory < ActiveRecord::Base
  belongs_to :Judge
  belongs_to :Category
end
