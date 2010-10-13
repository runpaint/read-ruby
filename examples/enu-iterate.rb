$places = %w{Agartha Atlantis Avalon Camelot Eden 
            El_Dorado Shangri-La Thule Utopia Valhalla}
$places.each_with_index.map{|place, index| "#{index}:#{place.size}"}
#=> ["0:7", "1:8", "2:6", "3:7", "4:4", "5:9", "6:10", "7:5", "8:6", "9:8"]
$places.reverse_each{|place| print place[0]}
# VUTSEECAAA
$places.each_with_object({}){|place,vowels| vowels[place] = place.downcase.count('aeiou')}
#=> {"Agartha"=>3, "Atlantis"=>3, "Avalon"=>3, "Camelot"=>3, "Eden"=>2, "El_Dorado"=>4, 
#=>  "Shangri-La"=>3, "Thule"=>2, "Utopia"=>4, "Valhalla"=>3}
class Places
  def each
    $places.group_by{|place| place[0]}.each{|letter, names| yield letter, *names}
  end
end
Places.new.extend(Enumerable).each_entry{|places| print " #{places.first}:#{places[1..-1].size}"}
# A:3 C:1 E:2 S:1 T:1 U:1 V:1 
