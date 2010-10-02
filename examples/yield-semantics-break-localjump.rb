Proc.new do
  p :alpha
  break
  p :beta 
end.call
#=> :alpha
#=> in `block in <main>': break from proc-closure (LocalJumpError)
