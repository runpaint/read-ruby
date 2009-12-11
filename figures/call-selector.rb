class Girl
  def initialize(name)
    @name = name.capitalize
  end
  
  def call(*sweet_nothings)
    "#@name: #{sweet_nothings.sample}..."
  end
end

jessica = Girl.new :jessica
jessica.call('Your eyes are a blue million miles', 'For all eternity')
#=> "Jessica: Your eyes are a blue million miles..."
rose = Girl.new :rose
rose.('I would walk 10, 000 miles', 'Superlatives cannot express')
#=> "Rose: Superlatives cannot express..."
