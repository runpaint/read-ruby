%w{mustache nokogiri pathname uri}.each{|n| require n}

module ReadRuby
  
  OUT_DIR = Pathname 'out'
  PRISTINE_DIR = Pathname 'www'
  TEMPLATE_EXT = '.mustache'
  ROOT_URL = URI.parse 'http://ruby.runpaint.org/'

  def dir name=nil
    name ? @dir = Pathname(name) : @dir
  end
  
  def target_ext ext=nil
    extension ext, :@target_ext
  end

  def source_ext ext=nil
    extension ext, :@source_ext
  end

  def target file
    path_for file, target_ext
  end

  def source file
    path_for file, source_ext
  end

  def each
    dir.each_child.select{|f| f.extname == source_ext}.each{|o| yield o}
  end

  private
  def extension ext, ivar
    ext ? instance_variable_set(ivar, '.' + ext) : instance_variable_get(ivar)
  end

  def path_for file, ext
    dir.join(Pathname(file).basename.sub_ext ext)
  end
end

Dir[File.dirname(__FILE__) + '/**/*rb'].
  reject{|f| f.end_with? 'browse.rb'}.
  each{|f| f[0] == '/' ? require(f) : require_relative(f) }
