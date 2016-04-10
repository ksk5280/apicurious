module ApplicationHelper
  def format_time(time)
    DateTime.parse(time).strftime("%I:%M%p %h-%m-%S")
  end
end
