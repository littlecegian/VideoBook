class Category < ActiveRecord::Base  
	def self.getcategoryname(categoryid)
		return Category.where(id: categoryid).pluck(:name)
	end	
end
