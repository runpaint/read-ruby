defined? $a #=> nil
defined? 3 + 2 #=> "method"
var = defined? true or nil #=> "true"
defined? var #=> "local-variable"
defined? 1.times { :one } #=> "expression"
defined? yield #=> nil
