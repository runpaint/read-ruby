class Toc < Mustache
  def headings
    CHAPTERS.map{|c| Chapter.new(c).headings}
  end

  def toc(toc=nil, depth=99)
    toc ||= headings
    return '' if depth < 1
    '<ol>' + toc.map do |e|
      '<li>' + (e.is_a?(Array) ? e.first + toc(e.last, depth-1) : e) + '</li>'
     end.join + '</ol>'
  end
end
