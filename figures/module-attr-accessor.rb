# encoding: utf-8
class King
  @numeral = Hash.new {|h,k| h[k] = 8543.chr('utf-8') }
  class << self; attr_accessor :numeral; end

  def initialize(name)
    King.numeral[@name = name].succ!
  end

  def name
    "#@name #{King.numeral[@name]}".delete " Ⅰ"
  end
end
%w{Henry Stephen Henry Richard John Henry Edward Edward 
   Edward Richard}.map {|name| King.new(name).name}.join(', ')
#=> Henry, Stephen, Henry Ⅱ, Richard, John, Henry Ⅲ, Edward, Edward Ⅱ, Edward Ⅲ, Richard Ⅱ

