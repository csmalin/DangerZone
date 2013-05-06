module ApplicationHelper


  def mins_since_midnight(time)
    # Takes a string with a 24-hour time formatted "HH:MM"
    (Time.parse(time).strftime("%H").to_i * 60) + Time.parse(time).strftime("%M").to_i
  end

end
