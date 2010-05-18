name = :size
# Sends "wool" the :name message
"wool".name #=> NoMethodError: undefined method `name' for "wool":String
# Sends "wool" the :size message
"wool".send(name) #=> 4
# Additional arguments to :send are sent as the message’s arguments
33.send(:/, 3) #=> 11

