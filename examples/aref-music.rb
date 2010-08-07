formats = %w{MP3 CD Cassette 8-Track Record}

def i_buy(format)
  "I buy my music on #{format.downcase}"
end

method(:i_buy)[ formats[2] ]
#=> "I buy my music on cassette"
method(:i_buy)[ formats[-2..-1].join(' or ' ) ]
#=> "I buy my music on 8-track or record"
