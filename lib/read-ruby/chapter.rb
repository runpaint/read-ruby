Footnote = Class.new Mustache

class Chapter < Mustache
  extend ReadRuby
  dir 'chapters'
  target_ext 'html'
  source_ext 'html'
  
  def self.all
    @@all ||= [Root.new.next].tap do |list|
      while nxt = list.last.next
        list << nxt
      end
    end
  end

  @@nok ||= {}

  attr_accessor :title, :nok, :name
  def initialize(name)
    @name = self.class.source(name).basename
    @nok = @@nok[@name] ||= Nokogiri::HTML(self.class.target(@name).read)
    @title = @nok.at('h1').inner_html
  end

  def next
    if (nxt = nok.at('link[@rel=next]'))
      self.class.new(nxt['href'][1..-1])
    end
  end

  def article
    nok.at('article').inner_html
  end

  def headings(s=nok.at('article'), level=1)
    a = ''
    unless (h1 = s.xpath('./h1')).inner_html.empty?
      href = '/' + name.sub_ext('').to_s
      anchor = h1.first.attributes['id'].to_s
      href += "##{anchor}" unless name.to_s =~ /^#{anchor}\./
      a = "<a href=#{href}>#{h1.inner_html}</a>"
    end
    titles = [a, 
              s.xpath('./section').map do |s2| 
                headings(s2, level + 1)
              end.compact
             ].reject(&:empty?)
    return if titles.empty?
    titles.size == 1 ? titles.first : titles
  end

  def footnotes
    nok.css('a').select{|a| a['href'].start_with? '#fn-'}.each_with_index do |a,i|
      footnote = Footnote.new
      footnote[:name], footnote[:index] = a['href'][4..-1], i.succ
      a.swap(footnote.render)
      nok.at("#fn-#{footnote[:name]}").tap do |li|
        footnote[:returner] = true
        li['id'] += "-#{footnote[:index]}"
        li.add_child(footnote.render)
      end
    end
  end

  def fixup
    footnotes
    nok.css('figure').map do |fig|
      if fig['id'] and fig['id'].end_with?('.rb')
          fig.at("figcaption").before(Example.target(fig['id']).read)
      elsif fig['class'] == 'railroad' 
        fig.css('img').each do |img|
          railroad = Railroad.target(img['id'])
          img['src'] = railroad.sub_ext('').to_s
          / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{railroad}`
          img['width'], img['height'] = width, height
          img.delete('id')
        end
      end
    end
  end
end
