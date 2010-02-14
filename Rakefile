# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
CLOBBER.include('out')
FIGURE_CSS = ['figure.railroad > img', 'figure[@id]']
EXTENSIONS = { '.rb' => '.html', '.ebnf' => '.png'}

directory 'out'

def headings(s, f, level=1)
  return if level > 2
  a = ''
  unless (h1 = s.xpath('./h1')).inner_html.empty?
    href = f.sub(/\.html$/,'') + '#' + h1.first.attributes['id']
    a = "<a href=#{href}>#{h1.inner_html.gsub(/ /,'&nbsp;')}</a>"
  end
  titles = [a, 
            s.xpath('./section').map{|s2| headings(s2, f, level + 1)}.compact
           ].reject(&:empty?)
  return if titles.empty?
  titles.size == 1 ? titles.first : titles
end

def toc(toc)
  '<ol>' + toc.map do |e|
    '<li>' + (e.is_a?(Array) ? e.first + toc(e.last) : e) + '</li>'
   end.join + '</ol>'
end

def write_html(nok, file)
  nok.css('link').last.after(File.read 'analytics.html')
  File.open(file, 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
  # Validate?
  sh "h5-min #{file} >#{file}.min"
  mv "#{file}.min", file
  sh "gzip --best -c #{file} >#{file}.gz"      
end

def chapter_dependecies(chapter)
  Nokogiri::HTML(File.read chapter).
    css(*FIGURE_CSS).
    select{|e| e['id'] =~ /\.[a-z]+$/}.
    map{|e| 'figures/' + e['id'].sub(/\.rb$/, '.html')} << chapter
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
  File.open(t.name, 'w'){|f| f.print images.values.first}
  sh "optipng #{t.name}"
end

rule(%r{figures/.+\.html} => ->(t){ source(t) }) do |t|
  sh "pygmentize -f html -O encoding=utf-8 -o #{t.name} #{t.source}"
  munged = File.read(t.name).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                             sub(/<\/pre><\/div>/,'</code></pre>')
  File.open(t.name,'w') {|f| f.print munged}
end

rule(%r{^out/.+\.html} => ->(t){ chapter_dependecies source(t)  }) do |t|
  source = t.prerequisites.last
  nok = Nokogiri::HTML(File.read source)
  nok.css(*FIGURE_CSS).each do |el|
    if el['id'] and el['id'].end_with?('.rb')
      file = target('figures/' + el['id'])
      el.at("figcaption").before(File.read file)
    elsif el['id'].end_with?('.png')
      el['src'] = path = "figures/#{el['id']}"
      el.delete('id')
      / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #{path}`
      el['width'], el['height'] = width, height
    end
  end
  write_html(nok, t.name)
end

file 'out/sitemap.xml' => FileList['*.html', 'sitemap.xml'] do |t|
  nok = Nokogiri::XML(File.read 'sitemap.xml')
  FileList['*.html'].reject{|f| f == 'index.html'}.each do |f|
    nok.at('urlset') << Nokogiri::XML::DocumentFragment.parse(
      "<url><loc>http://ruby.runpaint.org/#{f.sub(/\.html$/,'')}</loc></url>"
    )
  end
  File.open(t.name,'w'){|f| nok.write_to f}
end

file 'out/index.html' => FileList['*.html'] do |t|
  nxt, chapters = '/index', []
  while nxt
    nok = Nokogiri::HTML(File.read ".#{nxt}.html")
    chapters << headings(nok.at('section'), nxt) unless nxt.end_with?('index')
    nxt = nok.at('link[@rel=next]')
    nxt = nxt['href'] if nxt
  end
  nok = Nokogiri::HTML(File.read 'index.html')
  nok.at('section > section > h1').after(toc(chapters.compact))
  write_html(nok, t.name)
end

file 'out/figures' => ['out', 'figures'] do |t|
  ln_s '../figures', t.name
end

file 'out/style.css' => FileList['*.css'] + ['out'] do |t|
  File.open(t.name, 'w') do |f| 
    f.print FileList['*.css'].map{|n| File.read(n)}.join
  end
  sh "gzip --best -c #{t.name} >#{t.name}.gz"      
end

task :validate => FileList['out/*.html'] do |t|
  require 'h5-valid'
  t.prerequisites.each do |file|
    validator = HTML5::Validator.new(file)
    valid = validator.valid? ? 'OK' : "ERRORS (#{validator.errors.size})"
    puts "#{file}: #{valid}"
    puts "\t#{validator.errors_str}" unless validator.valid?
  end
end

rule(%r{out/} => ->(t){ t.sub('out/','')}) do |t|
  cp t.source, t.name
end


output_files = ['out', 'out/figures', 'out/style.css']
FileList['*.html', '*.xml', '*.txt', '.htstatic', '*.jpeg'].each do |f|
  next if f == 'analytics.html'
  output_files << (f_out = 'out/' + f)
end

task :default => output_files

task :upload => :default do
  sh "rsync --delete -vazL out/ ruby:/home/public"
  sh 'git push'
end
