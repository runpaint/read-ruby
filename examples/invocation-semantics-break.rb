hug = ->(who) do
  break "{#{who}}"
  :xxx # Not reached
end
name = :maria
p ["Hugging #{name}", hug.call(name), "Hugged #{name}"]
#=> ["Hugging maria", "{maria}", "Hugged maria"]
