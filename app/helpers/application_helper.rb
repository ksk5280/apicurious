module ApplicationHelper
  def format_time(time)
    DateTime.parse(time).strftime('%h-%m-%S %I:%M%p')
  end
end
