class Course < ApplicationRecord
    belongs_to:user
    has_and_belongs_to_many:categories
    has_and_belongs_to_many:locations
    has_many :votes, dependent: :destroy
    has_many :voted_users, through: :votes, source: :user
    
    validates :name,  presence: true,length:{minimum:10}
    validates :prerequisite ,  presence: true,  length:{minimum:10}
    validates :description ,  presence: true,  length:{minimum:30}
    
    mount_uploader :image, ImageUploader
    
    
end
