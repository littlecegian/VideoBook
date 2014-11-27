class Student < ActiveRecord::Base
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :uin, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates_format_of :email, :with => Authentication::RE_EMAIL_OK, :message => Authentication::MSG_EMAIL_BAD

	def self.getstudentname(studentid)		
		result = Student.where(id: studentid).pluck(:first_name,:last_name)
		#byebug
		return result
	end
end
