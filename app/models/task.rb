# ActiveRecord model for tasks
#
# Belongs to an Event and optionally, an assigned User
class Task < ApplicationRecord
    belongs_to :event
    belongs_to :user, optional: true
end
