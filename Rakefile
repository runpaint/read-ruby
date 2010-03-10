# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
require 'timeout'
require 'tempfile'
require 'uri'
require 'rspec/core/rake_task'

CLOBBER.include('out')
FIGURE_CSS = ['figure.railroad img', 'figure[@id]']
EXTENSIONS = { '.rb' => '.html', '.ebnf' => '.png'}
directory 'out'

def git_hash
  @git ||= `git rev-parse HEAD`.chomp
end

def headings(s, f, level=1)
  a = ''
  unless (h1 = s.xpath('./h1')).inner_html.empty?
    href = '/' + f + '#' + h1.first.attributes['id']
    a = "<a href=#{href}>#{h1.inner_html.gsub(/ /,'&nbsp;')}</a>"
  end
  titles = [a, 
            s.xpath('./section').map do |s2| 
              headings(s2, f, level + 1)
            end.compact
           ].reject(&:empty?)
  return if titles.empty?
  titles.size == 1 ? titles.first : titles
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

def all_headings
  return @chapters if defined?(@chapters)
  @chapters = []
  all_pages.each do |page|
    nok = Nokogiri::HTML(File.read page + '.html')
    @chapters << headings(nok.at('section'), page) unless page.end_with?('index')
  end
  @chapters.compact
end

def toc(toc, depth)
  return '' if depth < 1
  '<ol>' + toc.map do |e|
    '<li>' + (e.is_a?(Array) ? e.first + toc(e.last, depth-1) : e) + '</li>'
   end.join + '</ol>'
end

def write_html(nok, file)
  %w{_script _alpha-strip}.each do |file|
    nok.css('link').last.after(File.read file + '.html')
  end
  nok.at('section')['id'] = git_hash()
  File.open(file, 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
  # Validate?
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
    map{|e| 'figures/' + e['id'] }.
    map{|f| f.end_with?('rb') ? [f, f.sub(/\.rb$/, '.html')] : f}.
    flatten << chapter
end

def target(source)
  source.start_with?('figures/') ? source.gsub(/\.[a-z]+$/, EXTENSIONS) 
                                 : 'out/' + source
end

def source(target)
  src = target.start_with?('out/') ? target[4..-1] 
                                   : target.gsub(/\.[a-z]+$/, EXTENSIONS.invert)
  raise "#{src} is implied by #{target} but missing" unless File.exists?(src)
  src
end

rule(%r{figures/.+\.png$} => ->(t){ source(t) }) do |t|
  require 'pngrammar'
  images = PNGrammar.new(t.source).images
  raise "Generated #{images.size} PNGs; expected 1" unless images.size == 1
  raise "Couldn't make PNG for #{t.source}" unless images.values.first
  File.open(t.name, 'w'){|f| f.print images.values.first}
  sh "optipng #{t.name}"
end

def raises(file)
  Tempfile.open('spawn') do |temp|
    pid = spawn("ruby #{file}", :err => temp.path)
    begin
      Timeout.timeout(2) do
        break if Process.waitpid2(pid).last.success? 
        /\((?<e>[A-Z][a-z]\w+)\)\n/ =~ (error = temp.read)
        return e if e and e = Object.const_get(e) and e < Exception
        SyntaxError
      end
    rescue TimeoutError => e
      Process.kill(:KILL, pid)
      e.class
    end
  end
end

rule(%r{figures/.+\.html} => ->(t){ source(t) }) do |t|
  if ex = raises(t.source) and not File.read(t.source).include?(ex.to_s)
    unless ex == TimeoutError and 
           File.exist?("timeouts/#{File.basename(t.source)}")
      raise RuntimeError, "#{ex}: #{t.source}", caller.first
    end
  end
  sh "pygmentize -f html -O encoding=utf-8 -o #{t.name} #{t.source}"
  munged = File.read(t.name).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                             sub(/<\/pre><\/div>/,'</code></pre>')
  munged = %{<a href=/#{t.source}>#{munged}</a>}
  File.open(t.name,'w') {|f| f.print munged}
end

rule(%r{^out/google} => ->(t){ source t }) do |t|
  cp t.source, t.name
end

rule(%r{^out/.+\.html} => ->(t){ chapter_dependecies source(t)  }) do |t|
  source = t.prerequisites.last
  nok = Nokogiri::HTML(File.read source)
  nok.css(*FIGURE_CSS).each do |el|
    if el['id'] and el['id'].end_with?('.rb')
      #el.at('figcaption').remove
      file = target('figures/' + el['id'])
      el.at("figcaption").before(File.read file)
    elsif el['id'].end_with?('.png')
      el['src'] = (path = "figures/#{el['id']}").sub(/\.png$/,'')
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

file 'out/figures' => ['out', 'figures'] do |t|
  ln_s '../figures', t.name
end

file 'out/chapter.css' => FileList['{main,chapter,syntax}.css'] + ['out'] do |t|
  File.open(t.name, 'w') do |f| 
    f.print t.prerequisites[0..-2].map{|n| File.read(n)}.join
  end
end

rule(%r{out/} => ->(t){ t.sub('out/','')}) do |t|
  cp t.source, t.name
end

output_files = ['out', 'out/figures', 'out/chapter.css', 'out/main.css']
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

task :upload => :gzip do
  sh "rsync --delete -vazL out/ ruby:/home/public"
  sh 'git push'
end

Rspec::Core::RakeTask.new
