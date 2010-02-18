rvalue = Object.new
def rvalue.to_ary
  [:alpha, :beta]
end
a, b = rvalue
a #=> :alpha
b #=> :beta
