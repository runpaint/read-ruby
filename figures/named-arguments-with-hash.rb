class Chair
  def initialize(args)
    @legs = args[:legs] or raise ArgumentError
    @style = args[:style] || :victorian
    @height = args[:height] || :average
    @colour = args[:colour] || args[:color] || :brown
  end
end
Chair.new legs: 4, height: :tall #=> 
  ##<Chair:0x8249908 @legs=4, @style=:victorian,
  #@height=:tall, @colour=:brown>
Chair.new(:color => :fuschia, :legs => 7) #=>
  ##<Chair:0x86958f4 @legs=7, @style=:victorian,
  #@height=:average, @colour=:fuschia>
Chair.new(height: :childs, color: :fuschia) #=> ArgumentError 
