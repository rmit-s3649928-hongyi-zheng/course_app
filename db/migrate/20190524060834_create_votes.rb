class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :type

      t.timestamps
    end
  end
end
