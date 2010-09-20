# coding: utf-8
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

  def next_url
    self.next.name.sub_ext('') if self.next
  end

  def article
    article = nok.at('article').dup
    article.at('h1').remove
    article.inner_html
  end

  def main_sections
    h = headings(nok.at('article'))
    return unless h.is_a?(Array) 
    h = h.pop.flatten(1).select{|e| e.is_a? String}
    Toc.new.toc(h) if h.flatten.size < 20
  end

  def permalinks
    nok.at('article').css('h1[@id]')[1..-1].each do |h1|
      next if h1['class'] == 'runin'
      h1.inner_html = "<a title=permalink href=##{h1['id']}>§</a> #{h1.inner_html}"
    end
  end

  def headings(s=nok.at('article'), level=1)
    a = ''
    unless (h1 = s.xpath('./h1')).inner_html.empty?
      href = '/' + name.sub_ext('').to_s
      h = h1.first.dup
      h.at('a').remove if h.at('a')
      anchor = h.attributes['id'].to_s
      href += "##{anchor}" unless name.to_s =~ /^#{anchor}\./
      a = "<a href=#{href}>#{h.inner_html.strip}</a>"
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
        fig.at("figcaption").before(Example.target(fig['id']).sub('.html','.rb').read)
      elsif fig['class'] == 'railroad' 
        fig.css('img').each do |img|
          railroad = Railroad.target(img['id'])
          img['src'] = railroad.to_s
          / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{railroad}`
          img['width'], img['height'] = width, height
          img.delete('id')
        end
      end
    end
    permalinks
  end
end
