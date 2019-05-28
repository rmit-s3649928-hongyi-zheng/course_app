class Course < ApplicationRecord
    belongs_to:user
    belongs_to:category
    has_and_belongs_to_many:locations
    has_many :votes, dependent: :destroy
    has_many :voted_users, through: :votes, source: :user
    
    validates :name,  presence: true
    
    def assign_to?(location) 
        self.locations.include?(location) 
    end
    
    def unassigned_locations
        Location.all-self.locations
    end
    
end
