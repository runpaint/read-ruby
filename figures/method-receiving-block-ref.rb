def m(b)
  b.call
end
m ->{ "I am a \u{3bb}!" } #=> "I am a λ!"
