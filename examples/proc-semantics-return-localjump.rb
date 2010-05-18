Proc.new { p :alpha; return; p :beta }.call #=> :alpha
#=> in `block in <main>': unexpected return (LocalJumpError)
