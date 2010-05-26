hug = ->(who) do
  return "{#{who}}"
  :xxx # Not reached
end
name = :jess
p ["Hugging #{name}", hug.call(name), "Hugged #{name}"]
#=> ["Hugging jess", "{jess}", "Hugged jess"]
