# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
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
    data = contents
    File.open(target, 'w'){|f| f.print data}
    minify
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

  def dependencies
    @deps ||= nok.css('figure').map do |fig|
      if fig['id'] and fig['id'].end_with?('.rb')
        Example.new(fig['id'])
      elsif fig['class'] == 'railroad' 
        fig.css('img').map{|img| Railroad.new(img)}
      end
    end.flatten.compact
  end

  def contents
    nok.css('figure').map do |fig|
      if fig['id'] and fig['id'].end_with?('.rb')
          example = dependencies.select{|d| d.source.end_with? fig['id']}.first
          fig.at("figcaption").before(example.contents)
      elsif fig['class'] == 'railroad' 
        fig.css('img').each do |img|
          railroad = dependencies.select{|d| d.target.end_with? img['id']}.first
          img['src'] = railroad.url.path
          img.delete('id')
          / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{railroad.target}`
          img['width'], img['height'] = width, height
        end
      end
    end
    nok.to_s
  end
end

class Example < Page
  def initialize(source)
    @source = File.join('examples', source)
    super(@source, @source.sub(/\.rb$/, '.html'))
  end
    
  def minify?
  end

  def write
    system "pygmentize -f html -O encoding=utf-8 -o #{target} #{source}"
    munged = File.read(target).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                                    sub(/<\/pre><\/div>/,'</code></pre>')
    File.open(target, 'w'){|f| f.print %{<a href=#{url.path}>#{munged}</a>}}
    super
  end

  def contents
    File.read target
  end

  def url
    super.tap{|u| u.path = u.path + '.rb'}
  end
end

class Railroad < Page
  require 'pngrammar'
  attr_accessor :source, :target, :img
  
  def initialize(img)
    @img = img
    @target = File.join('railroads', @img['id'])
    @source = @target.sub(/\.png$/, '.ebnf')
  end

  # TODO: Unfinished
  def write
    images = PNGrammar.new(source).images
    raise "Generated #{images.size} PNGs; expected 1" unless images.size == 1
    raise "Couldn't make PNG for #{png}" unless images.values.first
    File.open(target, 'w'){|f| f.print images.values.first}
    system "optipng #{target}"
    Nokogiri::HTML(img.to_s).tap do |el|
      el['src'] = railroad.url.path
      / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{railroad.target}`
      el['width'], el['height'] = width, height
    end
  end

  def url
    ROOT_URL.tap{|u| u.path = '/' + target.sub(/\.png$/,'')}
  end
end

class Book
  CHAPTERS = %w{modules programs classes flow messages closures 
                methods objects variables}
  def chapters
    @chapters ||= CHAPTERS.map{|c| Chapter.new c}
  end

  def root
    @root ||= Root.new(ToC.new(chapters, 2).toc)
  end

  def toc
    @toc ||= ToC.new(chapters)
  end

  def sitemap
    @sitemap ||= Sitemap.new(chapters + chapters.map(&:dependencies) << toc << root)
  end

  def dependencies
    (chapters.dup << toc << root << sitemap).flatten 
  end
end

class ToC < Page
  attr_accessor :chapters, :depth
  def initialize(chapters, depth=99)
    @chapters, @depth = chapters, depth
    super('toc.html')
  end

  def headings
    chapters.reject{|c| c.name == 'index'}.map(&:headings).compact
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
  attr_reader :pages, :source, :target
  def initialize(pages)
    @pages = pages
    @source = 'sitemap.xml'
    @target = File.join('out', @source)
  end

  def write
    nok = Nokogiri::XML(File.read source)
    pages.flatten.map do |page|
      nok.at('urlset') << Nokogiri::XML::DocumentFragment.parse(
        "<url><loc>#{page.url}</loc></url>"
      )
    end
    File.open(target,'w'){|f| nok.write_to f}
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

output_files = ['out', 'out/main.css', 'out/chapter.css', 'out/railroads', 'out/examples']
FileList['*.txt', '.htstatic', '*.jpeg', '*.js'].each do |f|
  next if f.start_with?('_')
  output_files << (f_out = 'out/' + f)
end

book = Book.new
book.chapters.each do |chapter|
  chapter.dependencies.each do |dep|
    file dep.target => dep.source do
      dep.write
    end
  end
  file chapter.target => (chapter.dependencies.map(&:target) << chapter.source) do
    chapter.write
  end
end

chapters = book.chapters.map(&:target)

file book.root.target => chapters.dup << book.root.source do
  book.root.write
end

file book.toc.target => chapters.dup << book.toc.source do
  book.toc.write
end

file book.sitemap.target => chapters.dup << book.sitemap.source do
  book.sitemap.write
end

task :default => output_files + book.dependencies.map(&:target)

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
