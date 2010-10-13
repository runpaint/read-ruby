[300, 92, 827_99, -45, 300, 1].minmax #=> [-45, 82799]
languages = %w{Ruby Haskell Scala Clojure Perl Python Lisp Smalltalk}
languages.min #=> "Clojure"
languages.max #=> "Smalltalk"
languages.min{ +1 } #=> "Ruby"
languages.minmax{|a,b| a.ord <=> b.ord } #=> ["Clojure", "Scala"]
languages.sort.minmax do |a,b| 
  languages.count{|l| l.start_with?(a[0])} <=> languages.count{|l| l.start_with?(b[0])}
end #=> ["Clojure", "Perl"]
