# encoding: utf-8
#require 'rake/clean'
require 'nokogiri'
require 'timeout'
require 'tempfile'
require 'uri'
#require 'rspec/core/rake_task'

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
    if target.end_with?('html')
      system "h5-min #{target} >#{target}.min"
      FileUtils.mv "#{target}.min", target
    end
    system "gzip --best -c #{target} >#{target}.gz"      
  end

  def exists?
    File.exists? target
  end
end

class CSS < Page
  def initialize
    super('out/chapter.css')
  end

  def contents
    Dir.glob('*.css').map{|file| File.read file}.join
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
          example = Example.new(fig['id'])
          example.write
          contents = example.contents
          fig.at("figcaption").before(example.contents)
      elsif fig['class'] == 'railroad' 
        fig.css('img').each do |img|
          railroad = Railroad.new(img['id'])
          railroad.write
          img['src'] = '/' + railroad.target
          img.delete('id')
          / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{railroad.target}`
          img['width'], img['height'] = width, height
        end
      end
    end
  end

  def contents
    create
    nok.to_s
  end
end

class Example < Page
  def initialize(source)
    @source = File.join('examples', source)
    FileUtils.ln_s('../examples', 'out/examples') unless File.exist?('out/examples')
    super(@source, @source.sub(/\.rb$/, '.html'))
  end
    
  def create
    return if exists?
    warn "!!!Generating #{target}"
    system "pygmentize -f html -O encoding=utf-8 -o #{target} #{source}"
    munged = File.read(target).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                                    sub(/<\/pre><\/div>/,'</code></pre>')
    File.open(target, 'w'){|f| f.print %{<a href=/#{source}>#{munged}</a>}}
  end

  def contents
    create
    File.read target
  end
end

class Railroad
  require 'pngrammar'
  attr_accessor :source, :target
  
  def initialize(png)
    @target = File.join('railroads', png)
    @source = @target.sub(/\.png$/, '.ebnf')
    FileUtils.ln_s('../railroads', 'out/railroads') unless File.exist?('out/railroads')
  end
    
  def write
    return if File.exists?(target)
    warn "!!!Generating #{target}"
    images = PNGrammar.new(source).images
    raise "Generated #{images.size} PNGs; expected 1" unless images.size == 1
    raise "Couldn't make PNG for #{png}" unless images.values.first
    File.open(target, 'w'){|f| f.print images.values.first}
    system "optipng #{target}"
  end
end

class Book
  CHAPTERS = %w{enumerables modules programs text classes flow messages 
                numerics closures methods objects variables}
  def build
    FileUtils.mkdir_p('out')
    CSS.new.write
    chapters.each{|c| c.write}
    toc.write
    Root.new(ToC.new(chapters, 2).toc).write
  end

  def chapters
    @chapters ||= CHAPTERS.map{|c| Chapter.new c}
  end

  def toc
    ToC.new(chapters)
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

  def create
    nok.tap{|n| n.at('section > h1').after(toc)} 
  end

  def contents
    create
    nok.to_s
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
end
#chapter = Chapter.new('variables')
book = Book.new
book.build
__END__
CLOBBER.include('out')
FIGURE_CSS = ['figure.railroad img', 'figure[@id]']
EXTENSIONS = { '.rb' => '.html', '.ebnf' => '.png'}
directory 'out'

def git_hash
  @git ||= `git rev-parse HEAD`.chomp
end


def all_html_pages
  all_pages.map{|p| p + '.html'}
end


def all_pages
  return @pages if defined?(@pages)
  nxt, @pages = '/index', []
  while nxt
    @pages << page = nxt[1..-1]
    nok = Nokogiri::HTML(File.read page + '.html')
    nxt = nok.at('link[@rel=next]')
    nxt = nxt['href'] if nxt
  end
  @pages.compact
end


def write_html(nok, file)
  %w{_script _alpha-strip}.each do |file|
    nok.css('link').last.after(File.read file + '.html')
  end
  nok.at('section')['id'] = git_hash()
  File.open(file, 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
  if ENV['DEBUG']
    $stderr.puts "Not minifying HTML in debug mode"
  else
    sh "h5-min #{file} >#{file}.min"
    mv "#{file}.min", file
  end
end

def chapter_dependecies(chapter)
  Nokogiri::HTML(File.read chapter).
    css(*FIGURE_CSS).
    select{|e| e['id'] =~ /\.[a-z]+$/}.
    map do |f| 
      case e['id']
        when /\.rb$/ then "examples/#{e['id'].sub(/rb$/, 'html')}"
        when /\.png$/ then "railroads/#{e['id']}"
      end
    end.flatten << chapter
end

def target(source)
  source.start_with?('figures/') ? source.gsub(/\.[a-z]+$/, EXTENSIONS) 
                                 : 'out/' + source
end

def source(target)
  case target
    when %r{railroads/} then target.sub(/\.png$/, '.ebnf')
    when %r{examples/} then target.sub(/\.html$/, '.rb')
  end
end

rule(%r{railroads/.+\.png$} => ->(t){ source(t) }) do |t|
  require 'pngrammar'
  images = PNGrammar.new(t.source).images
  raise "Generated #{images.size} PNGs; expected 1" unless images.size == 1
  raise "Couldn't make PNG for #{t.source}" unless images.values.first
  File.open(t.name, 'w'){|f| f.print images.values.first}
  sh "optipng #{t.name}"
end

rule(%r{examples/.+\.html} => ->(t){ source(t) }) do |t|
  sh "pygmentize -f html -O encoding=utf-8 -o #{t.name} #{t.source}"
  munged = File.read(t.name).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                             sub(/<\/pre><\/div>/,'</code></pre>')
  munged = %{<a href=/#{t.source}>#{munged}</a>}
  File.open(t.name,'w') {|f| f.print munged}
end

rule(%r{^out/google} => ->(t){ source t }) do |t|
  cp t.source, t.name
end

rule(%r{^out/.+\.html} => [->(t){ chapter_dependecies source(t)  }, 'out/examples', 'out/railroads']) do |t|
  source = t.prerequisites.last
  nok = Nokogiri::HTML(File.read source)
  nok.css(*FIGURE_CSS).each do |el|
    if el['id'] and el['id'].end_with?('.rb')
      file = target('examples/' + el['id'])
      el.at("figcaption").before(File.read file)
    elsif el['id'].end_with?('.png')
      el['src'] = (path = "railroads/#{el['id']}").sub(/\.png$/,'')
      el.delete('id')
      / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{path}`
      el['width'], el['height'] = width, height
    end
  end
  write_html(nok, t.name)
end

file 'out/sitemap.xml' => (all_html_pages.map{|p| "out/#{p}"} << 'sitemap.xml') do |t|
  nok = Nokogiri::XML(File.read 'sitemap.xml')
  all_html_pages.map {|h| Nokogiri::HTML(File.read File.join('out', h)).css('a') }.
      flatten.
      map{|a| a['href']}.
      select{|a| a =~ %r{^(/|#)[^/]}}.
      map{|p| URI.join('http://ruby.runpaint.org/',p).
        tap{|u| u.fragment = nil}.
        tap{|u| u.path = (u.path == '/' ? u.path : u.path.sub(%r{/$}, '')) }
      }.
      uniq.each do |url|
        nok.at('urlset') << Nokogiri::XML::DocumentFragment.parse(
          "<url><loc>#{url.to_s}</loc></url>"
        )
      end
  File.open(t.name,'w'){|f| nok.write_to f}
end

file 'out/index.html' => FileList['*.html'] do |t|
  nok = Nokogiri::HTML(File.read 'index.html')
  nok.at('section > section > h1').after(toc(all_headings, 2))
  write_html(nok, t.name)
end

file 'out/toc.html' => FileList['*.html'] do |t|
  nok = Nokogiri::HTML(File.read 'toc.html')
  nok.at('section > h1').after(toc(all_headings, 99))
  write_html(nok, t.name)
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
end

rule(%r{out/} => ->(t){ t.sub('out/','')}) do |t|
  cp t.source, t.name
end

output_files = ['out', 'out/chapter.css', 'out/main.css']
FileList['*.html', '*.xml', '*.txt', '.htstatic', '*.jpeg', '*.js'].each do |f|
  next if f.start_with?('_')
  output_files << (f_out = 'out/' + f)
end

task :default => [*output_files, '_script.html']

task :gzip => :default do
  FileList['out/*html', 'out/*css'].each do |file|
    sh "gzip --best -c #{file} >#{file}.gz"      
  end
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

task :upload => [:clobber, :gzip, :local_spec] do
  sh "rsync --delete -vazL out/ ruby:/home/public"
  sleep 2
  Rake::Task[:live_spec].execute
  sh 'git push'
end

Rspec::Core::RakeTask.new(:rspec)
