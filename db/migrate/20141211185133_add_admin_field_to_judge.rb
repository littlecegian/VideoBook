class AddAdminFieldToJudge < ActiveRecord::Migration
  def change
  	add_column :judges, :admin, :boolean, :default => false
  end
end
