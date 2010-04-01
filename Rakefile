# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
require 'timeout'
require 'tempfile'
require 'uri'
require 'rspec/core/rake_task'

ROOT_URL = URI.parse 'http://ruby.runpaint.org/'

class Page
  attr_accessor :source, :target, :nok
  def initialize(source, target=nil)
    @target = target || source
    @source = source
    @target = @target.include?('/') ? @target : File.join('out',@target)
  end

  def nok
    @nok ||= Nokogiri::HTML(File.read source) 
  end

  def write
    return if exists?
    data = contents
    File.open(target, 'w'){|f| f.print data}
    minify
  end

  def exists?
    File.exists? target
  end

  def url
    ROOT_URL.tap{|u| u.path = '/' + target.sub(%r{out/},'').sub(%r{\.html$},'') }
  end

  def minify?
    true
  end

  def minify
    return unless minify?
    system "h5-min #{target} >#{target}.min"
    FileUtils.mv "#{target}.min", target
    system "gzip --best -c #{target} >#{target}.gz"      
  end
end

class Chapter < Page
  attr_accessor :name
  def initialize(name)
    @name = name.sub(/\.html$/,'')
    super(@name + '.html')
  end

  def headings(s=nok.at('section'), level=1)
    a = ''
    unless (h1 = s.xpath('./h1')).inner_html.empty?
      href = '/' + name + '#' + h1.first.attributes['id']
      a = "<a href=#{href}>#{h1.inner_html.gsub(/ /,'&nbsp;')}</a>"
    end
    titles = [a, 
              s.xpath('./section').map do |s2| 
                headings(s2, level + 1)
              end.compact
             ].reject(&:empty?)
    return if titles.empty?
    titles.size == 1 ? titles.first : titles
  end

  def create
    nok.css('figure').map do |fig|
      if fig['id'] and fig['id'].end_with?('.rb')
          example = dependencies.select{|d| d.source.end_with? fig['id']}.first
          example.write
          contents = example.contents
          fig.at("figcaption").before(example.contents)
      elsif fig['class'] == 'railroad' 
        fig.css('img').each do |img|
          railroad = dependencies.select{|d| d.target.end_with? img['id']}.first
          railroad.write
          img['src'] = railroad.url.path
          img.delete('id')
          / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{railroad.target}`
          img['width'], img['height'] = width, height
        end
      end
    end
  end

  def dependencies
    @deps ||= nok.css('figure').map do |fig|
      if fig['id'] and fig['id'].end_with?('.rb')
        Example.new(fig['id'])
      elsif fig['class'] == 'railroad' 
        fig.css('img').map{|img| Railroad.new(img['id'])}
      end
    end.flatten.compact
  end

  def exists?
    super and dependencies.all?{|d| d.exists?}
  end

  def contents
    create
    nok.to_s
  end
end

class Example < Page
  def initialize(source)
    @source = File.join('examples', source)
    super(@source, @source.sub(/\.rb$/, '.html'))
  end
    
  def create
    return if exists?
    system "pygmentize -f html -O encoding=utf-8 -o #{target} #{source}"
    munged = File.read(target).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                                    sub(/<\/pre><\/div>/,'</code></pre>')
    File.open(target, 'w'){|f| f.print %{<a href=#{url.path}>#{munged}</a>}}
  end

  def minify?
  end

  def contents
    create
    File.read target
  end

  def url
    super.tap{|u| u.path = u.path + '.rb'}
  end
end

class Railroad
  require 'pngrammar'
  attr_accessor :source, :target
  
  def initialize(png)
    @target = File.join('railroads', png)
    @source = @target.sub(/\.png$/, '.ebnf')
  end
    
  def exists?
    File.exists?(target)
  end

  def write
    return if exists?
    images = PNGrammar.new(source).images
    raise "Generated #{images.size} PNGs; expected 1" unless images.size == 1
    raise "Couldn't make PNG for #{png}" unless images.values.first
    File.open(target, 'w'){|f| f.print images.values.first}
    system "optipng #{target}"
  end

  def url
    ROOT_URL.tap{|u| u.path = '/' + target.sub(/\.png$/,'')}
  end
end

class Book
  CHAPTERS = %w{modules programs classes flow messages closures 
                methods objects variables}
  def build
    chapters.each{|c| c.write}
    toc = ToC.new(chapters)
    toc.write
    root = Root.new(ToC.new(chapters, 2).toc)
    root.write
    Sitemap.new(chapters << chapters.map(&:dependencies) << toc << root).write
  end

  def chapters
    @chapters ||= CHAPTERS.map{|c| Chapter.new c}
  end
end

class ToC < Page
  attr_accessor :chapters, :depth
  def initialize(chapters, depth=99)
    @chapters, @depth = chapters, depth
    super('toc.html')
  end

  def headings
    chapters.reject{|c| c.name == 'index'}.map do |c|
      c.headings
    end.compact
  end

  def toc(toc=nil, depth=nil)
    toc ||= headings
    depth ||= self.depth
    return '' if depth < 1
    '<ol>' + toc.map do |e|
      '<li>' + (e.is_a?(Array) ? e.first + toc(e.last, depth-1) : e) + '</li>'
     end.join + '</ol>'
  end

  def contents
    nok.tap{|n| n.at('section > h1').after(toc)}
  end
end

class Root < Page
  attr_accessor :front_toc
  def initialize(front_toc)
    @front_toc = front_toc
    super('index.html')
  end

  def contents
    nok.tap{|n| n.at('section > section > h1').after(front_toc)}
  end

  def url
    super.tap{|u| u.path = '/'}
  end
end

class Sitemap
  attr_reader :pages
  def initialize(pages)
    @pages = pages
  end

  def write
    nok = Nokogiri::XML(File.read 'sitemap.xml')
    pages.flatten.map do |page|
      nok.at('urlset') << Nokogiri::XML::DocumentFragment.parse(
        "<url><loc>#{page.url}</loc></url>"
      )
    end
    File.open('out/sitemap.xml','w'){|f| nok.write_to f}
  end
end

CLOBBER.include('out')
directory 'out'

rule(%r{^out/google} => ->(t){ source t }) do |t|
  cp t.source, t.name
end

%w{examples railroads}.each do |dir|
  out_dir = File.join('out', dir)
  file out_dir => ['out', dir] do |t|
    ln_s "../#{dir}", t.name
  end
end

file 'out/chapter.css' => FileList['{main,chapter,syntax}.css'] + ['out'] do |t|
  File.open(t.name, 'w') do |f| 
    f.print t.prerequisites[0..-2].map{|n| File.read(n)}.join
  end
  sh "gzip --best -c #{t.name} >#{t.name}.gz"      
end

rule(%r{out/} => ->(t){ t.sub('out/','')}) do |t|
  cp t.source, t.name
end

output_files = ['out', 'out/chapter.css', 'out/main.css', 'out/railroads', 'out/examples']
FileList['*.txt', '.htstatic', '*.jpeg', '*.js'].each do |f|
  next if f.start_with?('_')
  output_files << (f_out = 'out/' + f)
end

task :default => output_files do
  Book.new.build
end

task :spec => :local_spec

task :local_spec do
  ENV['READ_RUBY_HOST'] = 'read-ruby'
  Rake::Task[:rspec].execute
end

task :live_spec do
  ENV['READ_RUBY_HOST'] = 'ruby.runpaint.org'
  Rake::Task[:rspec].execute
end

task :upload => [:clobber, :local_spec] do
  sh "rsync --delete -vazL out/ ruby:/home/public"
  sleep 2
  Rake::Task[:live_spec].execute
  sh 'git push'
end

Rspec::Core::RakeTask.new(:rspec)
