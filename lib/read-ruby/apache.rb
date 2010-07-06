class Apache < Mustache
  include ReadRuby
  def dir
    File.expand_path '.'
  end
end
