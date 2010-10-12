elements = {H: :hydrogen,  Li: :lithium, Na: :sodium, K: :potassium, 
            Rb: :rubidium, Cs: :caesium, Fr: :francium}
elements.delete(:Fr) #=> :francium
elements.delete(:O){ false } #=> false
elements.shift #=> [:H, :hydrogen]
elements.delete_if{|sym, name| sym.size == 1}
#=> {:Li=>:lithium, :Na=>:sodium, :Rb=>:rubidium, :Cs=>:caesium}
elements.reject{|sym, name| name =~ /um/} #=> {}
elements.select!{|sym, name| name.to_s.end_with?(?m)} #=> nil
elements.replace({li: 'list item', p: 'paragraph', hr: 'horizontal rule'})
#=> {:li=>"list item", :p=>"paragraph", :hr=>"horizontal rule"}
