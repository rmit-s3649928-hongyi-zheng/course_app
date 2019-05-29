class AddDescriptionToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :description, :string,default:"this is a default description"
  end
end
