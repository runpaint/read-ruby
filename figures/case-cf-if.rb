class Integer
  def ordinal
    if    to_s =~ /^1\d$/ then 'th'
    elsif to_s =~ /1$/    then 'st'
    elsif to_s =~ /2$/    then 'nd'
    elsif to_s =~ /3$/    then 'rd'
    else                       'th'
    end
  end
end
[1,2,3,4].map{|n| "#{n}#{n.ordinal}"} #=> ["1st", "2nd", "3rd", "4th"]

class Integer
  def ordinal
    case to_s
      when /^1\d$/ then 'th'
      when /1$/    then 'st'
      when /2$/    then 'nd'
      when /3$/    then 'rd'
      else              'th'
    end
  end
end
[1,2,3,4].map{|n| "#{n}#{n.ordinal}"} #=> ["1st", "2nd", "3rd", "4th"]
