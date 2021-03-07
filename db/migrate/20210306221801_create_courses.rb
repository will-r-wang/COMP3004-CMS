class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_code
      t.integer :capacity

      t.timestamps
    end
  end
end
