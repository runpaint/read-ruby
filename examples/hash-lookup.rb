vitamins = {apricot: :a, ham: :b1, cabbage: :c, spinach: :k}
vitamins[:apricot] #=> :a
vitamins.fetch(:pizza, '???') #=> "???"
vitamins.fetch(:kale){|food| [:a, :c, :d, :e, :k].sample} #=> :c
vitamins.values_at(:spinach, :cheese, :ham) #=> [:k, nil, :b1]
vitamins.assoc(:cabbage) #=> [:cabbage, :c]
vitamins.rassoc(:c)      #=> [:cabbage, :c]
