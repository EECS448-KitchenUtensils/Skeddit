# Provides extension methods for DateTime objects
class DateTime
  # Converts to 24-hour (military) time
  # PRE:: None
  # POST:: None
  def hour_24
    self.strftime("%H:%M")
  end

  # Converts to 12-hour (civilian) time
  # PRE:: None
  # POST:: None
  def hour_12
    self.strftime("%I:%M %p")
  end
end