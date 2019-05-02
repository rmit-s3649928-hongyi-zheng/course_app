class Course < ApplicationRecord
    belongs_to:coordinator
    belongs_to:category
    has_and_belongs_to_many:locations
    
    def assign_to?(location) 
        self.locations.include?(location) 
    end
    
    def unassigned_locations
        Location.all-self.locations
    end
    
end
