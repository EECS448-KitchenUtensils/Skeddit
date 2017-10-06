class Event < ApplicationRecord
  # Every event belongs to an 'admin' user, and has many availabilites and 'participants' (users)
  # through its availabilities.
  # When an event is destroyed, so are all of its related availabilities.
  belongs_to :owner, class_name: :User
  has_many :availabilities
  has_many :tasks

  # # Run compact_times_allowed method before saving an event to the database.
  # before_save :compact_times_allowed
  # before_save :ensure_times_allowed_has_correct_date

  # # Ensures data is in an allowable format before adding it to the database
  validate :name_cannot_be_empty, :date_cannot_be_in_the_past
  
  # Array of DateTime values iterating through every 30 minutes on today's date starting from midnight.
  POSSIBLE_TIMES_CONST = Array.new(48).map.with_index{|x,index| Date.today.to_datetime + index * (1.0/48)}

  private

  # # Delete all nil values from times_allowed array using ruby's compact method.
  # # PRE: None
  # # POST: Nil values removed from times_allowed
  # def compact_times_allowed
  #   self.times_allowed = self.times_allowed.compact
  # end
  
  # Ensures the name field is not empty
  # PRE: name exists
  # POST: If name is blank, add an error to errors hash.
  def name_cannot_be_empty
    if self.name.blank?
      self.errors[:base] << "Name cannot be empty"
    end
  end
  
  # Verifies event date is not before today and in order
  # PRE: date exists
  # POST: If date is earlier than today, add an error to errors hash.
  def date_cannot_be_in_the_past
    if self.start < Date.today
      self.errors[:base] << "Cannot choose a date in the past"
    end
    if self.start >= self.end
      self.errors[:base] << "Dates not chronological"
    end
  end

end
