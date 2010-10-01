# encoding: utf-8
greek = %w{alpha beta gamma delta}
greek[0] = ?α          #=> "α"
greek[1, 2] = [?β, ?γ] #=> ["β", "γ"]
greek[-1] = ?δ         #=> "δ"
greek                  #=> ["α", "β", "γ", "δ"]
