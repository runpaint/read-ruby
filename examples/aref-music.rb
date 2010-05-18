formats = %w{MP3 CD Cassette 8-Track Record}

def i_buy(format)
  "I buy my music on #{format.downcase}"
end

# Array#[] is given an Integer subscript, which in this case
# returns the third element: 'Cassette'. The Method object is then
# indexed by 'Cassette', which sends Object the :i_buy message with
# 'Cassette' as an argument. 
method(:i_buy)[ formats[2] ] #=> "I buy my music on cassette"

# This time we index the same Array with a Range, which returns an
# Array comprising the last two elements of the receiver. We
# concatenate these elements to produce a String "8-Track or Record",
# with which we index the Method object, as before.
method(:i_buy)[ formats[-2..-1].join(' or ' ) ] #=> "I buy my music on 8-track or record"
