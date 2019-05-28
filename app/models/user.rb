class User < ApplicationRecord
  has_many:courses
  has_many :votes, dependent: :destroy
  has_many :upvoted_courses, through: :votes, source: :course
  validates :name,  presence: true, length: { minimum: 4 }
  RMIT_EMAIL_REGEX = /[a-z]+\.[a-z]+@rmit\.edu\.au/i
  validates :email, presence: true, length: { minimum: 4 },
                    format: { with: RMIT_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password  
  
  PASSWORD_REGEX = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\W)[a-zA-Z0-9]/
  validates :password, presence: true, 
                       length: { minimum: 8 },
                       format:{with: PASSWORD_REGEX}
end
