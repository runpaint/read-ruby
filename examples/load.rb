load './a.rb' #=> true
@ivar #=> :i
@ivar = :j
load './a.rb' #=> true
@ivar #=> :i
