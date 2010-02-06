require 'mechanize'
class Array
  def to_hash
    Hash[*self]
  end
end
class EBNF
  attr_reader :ebnf, :ua
  URL = "http://www-cgi.uni-regensburg.de/~brf09510/syntax.html"
  def initialize(file)
    @ebnf = File.read(file)
    @ua = WWW::Mechanize.new
  end

  def nonterminals
    ebnf.scan(/^\s*([^=]+)/).map{|md| md.last.strip}
  end

  def images
    nonterminals.zip(
      results.css('img').
              map{|i| ua.get_file(i['src'])}.
              first(nonterminals.size)
    ).to_hash
  end

  def results
    @results ||= ua.get(URL).forms.first.tap do |f| 
      f['ssyntax'] = ebnf
      f['width'] = 1000
    end.submit.parser
  end
end
