(1...1000).select{|n| n.to_s(16).end_with?('ef')} #=> [239, 495, 751]
fruits = {raspberry: :red, grape: [:white, :black], banana: :yellow, orange: :orange}
fruits.select{|fruit, colour| fruits.key?(colour)} #=> {:orange => :orange}
(0..9).reject(&:even?) #=> [1, 3, 5, 7, 9]
