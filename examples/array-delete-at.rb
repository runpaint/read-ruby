at = Array.instance_methods(false).grep(/at$/)
#=> [:at, :concat, :values_at, :delete_at]
at.delete_at 1 #=> :concat
at.shift       #=> :at
at.pop         #=> :delete_at
at             #=> [:values_at]
