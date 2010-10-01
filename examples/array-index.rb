ruler = [*'Ramesses II'.chars]
ruler.index('e') #=> 3
ruler.rindex('e') #=> 6
ruler.index {|e| e =~ /[[:upper:]]/} #=> 0
