variable = :first
closure = ->{ "variable = #{variable}" }
closure.call #=> "variable = first"
variable = :second
closure.call #=> "variable = second"
