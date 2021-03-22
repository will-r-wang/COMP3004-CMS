class Course < ApplicationRecord
    has_many :activity
    has_and_belongs_to_many :student
    has_and_belongs_to_many :semester
    has_many: courseaddon
    belongs_to: registration
    has_many: announcement
    has_and_belongs_to_many: teacher
end
