class Root < Mustache
  def front_toc
    Toc.new.toc(nil, 2)
  end
end
