# ActiveRecord model for Event time slots
# 
# Each Availablity 'belongs to' an Event and a User.
# 
# If an availability's User or Event is destroyed, so is the Availability.
class Availability < ApplicationRecord
  belongs_to :event
  has_and_belongs_to_many :users

  #validate :dates_are_valid
  

  # Run compact_times_allowed method before saving an availability to the database.
  # before_save :compact_times_available

  private

  # # VALIDATION Makes sure they have a date entered.
  # def dates_are_valid
  #   if ((start_date.strftime("%m/%d/%Y") rescue ArgumentError) == ArgumentError)
  #     self.errors[:start_date] << "Invalid start date"
  #   end  
  #   if ((end_date.strftime("%m/%d/%Y") rescue ArgumentError) == ArgumentError)
  #     self.errors[:end_date] << "Invalid end date"
  #   end 
  # end

  # TODO
  # VALIDATION Check that times are chronological

  # TODO
  # VALIDATION Check that times do not overlap with your other times. May or may not do this?


end
