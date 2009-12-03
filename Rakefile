# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
CLOBBER.include('out')
OUTPUT_FILES = FileList['*.css', '*.html', '.htstatic'].map{|f| "out/#{f}"}
OUTPUT_HTML = OUTPUT_FILES.select{|f| f.end_with?('.html')}
directory 'out'

HIGHLIGHTED_FIGURES = FileList['figures/*.rb'].map{|f| f.sub(/rb$/, 'html')}

rule(/figures\/.+\.html/ => '.rb') do |t|
  sh "pygmentize -f html -O encoding=utf-8 -o #{t.name} #{t.source}"
  munged = File.read(t.name).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                             sub(/<\/pre><\/div>/,'</code></pre>')
  File.open(t.name,'w') {|f| f.print munged}
end

source_lambda = ->(t){ t.sub(/out\//, '') }

rule 'out/index.html' => FileList['*.html'] do |t|
  nxt = '/index'
  chapters = []
  while nxt
    nok = Nokogiri::HTML(File.read ".#{nxt}.html")
    chapters << headings(nok.css('body > section'), nxt) unless nxt.end_with?('index')
    nxt = nok.at('link[@rel=next]')
    nxt = nxt['href'] if nxt
  end
  nok = Nokogiri::HTML(File.read 'index.html')
  nok.at('section > section > h1').after(toc(chapters.compact))
  File.open('out/index.html', 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
end


rule(/out\/.+.html$/ => [source_lambda] + HIGHLIGHTED_FIGURES) do |t|
  nok = Nokogiri::HTML(File.read t.source)
  has_figures = false
  nok.css('figure').each do |figure|
    id = figure.attributes['id'].value
    if file = t.prerequisites.grep(/#{id}.html$/).first    
    # Warn if the figure has no dd or file?
      figure.at('dt').before "<dd>#{File.read file}</dd>"
      has_figures = true
    end
  end
  nok.at('title').after("<link href=pygments.css rel=stylesheet>") if has_figures
  nok.write_html_to(File.new(t.name, 'w'), encoding: 'UTF-8')
end

rule(/out\/.+css/ => [source_lambda] << 'out') do |t|
  cp t.source, t.name
end

rule(/out\// => [source_lambda]) do |t|
  cp t.source, t.name
end

task :minimise => OUTPUT_HTML do |t|
  t.prerequisites.each do |p|
    sh "h5-min #{p} > #{p}.min"
    mv "#{p}.min", p
    sh "gzip --best -c #{p} > #{p}.gz"
  end
end


def headings(s, f)
  a = ''
  unless (h1 = s.xpath('./h1')).inner_html.empty?
    href = f.sub(/\.html$/,'') + '#' + h1.first.attributes['id']
    a = "<a href=#{href}>#{h1.inner_html}</a>"
  end
  titles = [a, 
            s.xpath('./section').map{|s2| headings(s2, f)}.compact
           ].reject(&:empty?)
  return if titles.empty?
  titles.size == 1 ? titles.first : titles
end

def toc(toc)
  '<ol>' + toc.map do |e|
    '<li>' + (e.is_a?(Array) ? e.first + toc(e.last) : e) + '</li>'
   end.join + '</ol>'
end

task :default => [*OUTPUT_FILES, :minimise]

task :upload => [:default, :sitemap] do
  sh "rsync --delete -vaz out/ ruby:/home/public"
end

task :sitemap => :default do
  nok = Nokogiri::XML(File.read 'sitemap.xml')
  FileList['*.html'].reject{|f| f == 'index.html'}.each do |f|
    nok.at('urlset') << Nokogiri::XML::DocumentFragment.parse(
      "<url><loc>http://ruby.runpaint.org/#{f.sub(/\.html$/,'')}</loc></url>"
    )
  end
  File.open('out/sitemap.xml','w'){|f| nok.write_to f}
end
