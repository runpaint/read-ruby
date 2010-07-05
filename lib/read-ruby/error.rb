# TODO: Return the right status code, preferably without having to use CGI
class Error < Mustache
  extend ReadRuby
  dir 'errors'
  target_ext 'html'
  source_ext 'html'
  
  attr_accessor :title, :nok, :name
  def initialize(name)
    @name = self.class.source(name).basename
    @nok = Nokogiri::HTML(self.class.target(@name).read)
    @title = @nok.at('h1').inner_html
  end

  def message
    section = nok.at('section').dup
    section.at('h1').remove
    section.inner_html
  end
end
