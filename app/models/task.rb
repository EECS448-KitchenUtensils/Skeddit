class Task < ApplicationRecord
    belongs_to :event
    belongs_to :owner, class_name: :User
end
