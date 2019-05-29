class AddDescriptionToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :description, :String,default:"this is a default description"
  end
end
