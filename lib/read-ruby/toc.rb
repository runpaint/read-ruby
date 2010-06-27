class Toc < Mustache
  def headings
    Chapter.all.map(&:headings)
  end

  def toc(toc=nil, depth=99)
    toc ||= headings
    return '' if depth < 1
    '<ol>' + toc.map do |e|
      '<li>' + (e.is_a?(Array) ? e.first + toc(e.last, depth-1) : e) + '</li>'
     end.join + '</ol>'
  end
end
