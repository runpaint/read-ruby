[300, 92, 827_99, -45, 300, 1].minmax_by(&:magnitude) #=> [1, 82799]
languages = %w{Ruby Haskell Scala Clojure Perl Python Lisp Smalltalk}
languages.min_by(&:size) #=> "Ruby"
languages.max_by{|l| l.codepoints.reduce(:+)} #=> "Smalltalk"
languages.minmax_by{|l| l.ord } #=> ["Clojure", "Scala"]
languages.sort.minmax_by {|l| languages.count{|e| l.start_with?(e[0])}}
#=> ["Clojure", "Perl"]
