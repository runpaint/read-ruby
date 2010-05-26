def scope
  variable = 1
  3.times do
    variable += 1 
  end
  variable
end
scope #=> 4
defined? variable #=> nil
