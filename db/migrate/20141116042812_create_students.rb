class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :uin, limit: 8
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :students, :email, unique: true
    add_index :students, :uin, unique: true
  end
end
