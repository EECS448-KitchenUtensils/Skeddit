class Task < ApplicationRecord
    belongs_to :event
    has_one :participant, class_name: :User
end
