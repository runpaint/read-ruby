h = {}
h[:key] = :value #=> :value
h.store("Key", "Value") #=> "Value"
h["Key"] = "Ring" #=> "Ring"
h #=> {:key=>:value, "Key"=>"Ring"}
