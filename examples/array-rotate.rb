alpha = [*(?a..?z)]
rot13 = 'Read Ruby 1.9'.chars.map do |c|
  if alpha.include?(d = c.downcase)
    alpha.rotate! until alpha.first == d
    d = alpha.rotate(13).first
    c.downcase! ? d.upcase : d
  else
    c
  end
end.join
rot13 #=> "Ernq Ehol 1.9"
