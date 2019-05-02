class Location < ApplicationRecord
    has_and_belongs_to_many:courses
    
    def name
       "#{building}.#{floor}.#{room}"
    end
end
