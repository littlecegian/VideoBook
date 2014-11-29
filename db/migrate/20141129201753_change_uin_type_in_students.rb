class ChangeUinTypeInStudents < ActiveRecord::Migration
  def change
  	change_column :students, :uin, :string
  end
end
