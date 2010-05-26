class Chair
  DEFAULT_ARGS = {legs: 2, style: :victorian, height: :average, colour: :brown}
  def initialize(args)
    @attributes = DEFAULT_ARGS.merge args
  end
end
Chair.new legs: 4, height: :tall #=>
  #<Chair:0x9039af4 @attributes={
  #:legs=>4,       :style=>:victorian, 
  #:height=>:tall, :colour=>:brown
  #};>
Chair.new(:color => :fuschia, :legs => 7) #=>
  ##<Chair:0x998a9dc @attributes={
  #:legs=>7, :style=>:victorian, 
  #:height=>:average, :colour=>:fuschia
  #}>;
