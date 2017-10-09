class Event < ApplicationRecord
  # Every event belongs to an 'admin' user, and has many availabilites and 'participants' (users)
  # through its availabilities.
  # When an event is destroyed, so are all of its related availabilities.
  belongs_to :owner, class_name: :User
  has_many :availabilities
  has_many :tasks, dependent: :destroy

  # Validations
  validate :name_cannot_be_empty, :date_cannot_be_in_the_past

  private
  
  # Ensures the name field is not empty
  # PRE:: name exists
  # POST:: If name is blank, add an error to errors hash.
  def name_cannot_be_empty
    if self.name.blank?
      self.errors[:base] << "Name cannot be empty"
    end
  end
  
  # Verifies event date is not before today and in order
  # PRE:: date exists
  # POST:: If date is earlier than today, add an error to errors hash.
  def date_cannot_be_in_the_past
    if self.start < Date.today
      self.errors[:base] << "Cannot choose a date in the past"
    end
    if self.start >= self.end
      self.errors[:base] << "Dates not chronological"
    end
  end

end
