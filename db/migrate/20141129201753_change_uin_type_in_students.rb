class ChangeUinTypeInStudents < ActiveRecord::Migration
  def self.up
  	change_column :students, :uin, :string
  end

  def self.down
  	change_column :students, :uin, :integer
  end
end
