class Root < Mustache
  def front_toc
    Toc.new.toc(nil, 2)
  end

  def next
    chap = Nokogiri::HTML(File.read self.class.template_file).
      at('link[@rel=next]')['href'][1..-1]
    Chapter.new chap
  end
end
