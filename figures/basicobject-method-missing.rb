class BasicObject
  public :method_missing
end
b = BasicObject.new
b.method_missing :glark #=> NoMethodError: undefined method `glark' for #<BasicObject:0x93ace0c>
