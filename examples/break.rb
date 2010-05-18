(1..20).map{|i| i.to_s(2)}.each do |binary|
  break binary if binary.size > 4 && binary[-1] == '1'
end #=> "10001"
