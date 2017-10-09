# Devise model for users
#
# User can have many Event and Availability.
#
# If a user is destroyed, all of their events and availabilities are destroyed as well.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :events
  has_and_belongs_to_many :availabilities

  # # Check to see if a user said they were available for a specified event at a specified time.
  # # PRE:: None
  # # POST:: None
  # def is_available_at_event_and_time?(event,time)
  #   self.availabilities.find_by(event_id: event.id).times_available.include?(time)
  # end
end
