Object.new.methods.grep /^[[:alpha:]]+\?/
#=> [:nil?, :eql?, :tainted?, :untrusted?, :frozen?, :equal?]
[].methods.grep /!/
#=> [:reverse!, :rotate!, :sort!, :sort_by!, :collect!, :map!, 
#    :select!, :reject!, :slice!, :uniq!, :compact!, :flatten!, 
#    :shuffle!, :!~, :!, :!=]
String.methods false #=> [:try_convert]
private_methods.grep /[[:upper:]]/
#=> [:Integer, :Float, :String, :Array, :Rational, :Complex]
Object.new.tap{|o| o.define_singleton_method(:s, ->{})}.methods(false)
#=> [:s]
