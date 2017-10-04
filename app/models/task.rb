class Task < ApplicationRecord
    belongs_to :event
    has_one :owner, class_name: :User
end
