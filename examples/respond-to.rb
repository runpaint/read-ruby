Math::PI #=> 3.141592653589793
Math::PI.respond_to? :floor #=> true
Math::PI.floor #=> 3
Math::PI.methods.all?{|m| Math::PI.respond_to? m} #=> true
Math::PI.respond_to? :door #=> false
Math::PI.door #=> NoMethodError: undefined method `door' for 3.141592653589793:Float
