class Judge < ActiveRecord::Base
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :tamu, inclusion: [true, false] #validates presence of will fail. since rails 4 assume false = absence
	validates :preference, presence: true
	validates :preference, inclusion: %w(All Category Contestant)
	validates_format_of :email, :with => Authentication::RE_EMAIL_OK, :message => Authentication::MSG_EMAIL_BAD
	attr_accessor :contestant_first_name
  attr_accessor :contestant_last_name
  attr_accessor :category_name

    after_initialize :set_preference

    def set_preference
    	self.preference ||= "All"
    end

    def self.getpreference(judgeid)
    	return Judge.where(["id = ?", judgeid]).select("preference").first
    end    

    def self.isjudgepresent(emailid)
    	return Judge.find_by_email(emailid)
    end

end
