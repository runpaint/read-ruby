begin
  raise SystemExit.new(1), "Abnormal exit"
rescue SystemExit => e
  "Caught exit with status #{e.status}: #{e.message}"
end #=> "Caught exit with status 1: Abnormal exit"

def move
  raise LocalJumpError, "Try hopping or skipping", ["Buy Thriller DVD",
                                                    "[redacted]",
                                                    "Rise up, legs akimbo"]
rescue => e 
  return "#{e.class}: <#{e.message}> from <#{e.backtrace.first}>??"
end

move
#=> "LocalJumpError: <Try hopping or skipping> from <Buy Thriller DVD>??"
