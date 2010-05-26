begin
  # 1. Raises a RuntimeError with 'Disaster' as the message
  raise "Disaster"
# RuntimeError is a subclass of StandardError, so this clause matches
# the exception raised above and assigns it to local variable e
rescue => e
  e.message
end #=> 'Disaster'
