class Railroad
  extend ReadRuby
  dir 'railroads'
  source_ext 'ebnf'
  target_ext 'png'

  def self.generate from
    require 'pngrammar'
    to = target from
    open(to, 'w'){|f| f.print PNGrammar.new(from).image}
    sh "optipng #{to}"
  end
end
