# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
CLOBBER.include('out')
directory 'out'
directory 'out/railroad'

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

task :upload => :default do
  sh "rsync --delete -vaz out/ ruby:/home/public"
  sh 'git push'
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
  File.open(t.name, 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
end

OUTPUT_FILES = ['out/style.css']

file 'out/style.css' => FileList['*.css'] + ['out'] do |t|
  File.open(t.name, 'w') do |f| 
    f.print FileList['*.css'].map{|n| File.read(n)}.join
  end
  sh "gzip --best -c #{t.name} >#{t.name}.gz"      
end

class PNG
  attr_reader :width, :height
  def initialize(file)
    @file = file
    dimensions
  end
  
  def dimensions
    / PNG (?<width>\d+)x(?<height>\d+)/ =~ `identify #@file`
    @width, @height = [width, height].map(&:to_i)
  end
end

FileList['railroad/*.ebnf'].each do |ebnf|
  require 'pathname'
  OUTPUT_FILES << png = "out/#{Pathname.new(ebnf).sub_ext('.png').to_path}" 
  file png => [ebnf, 'out/railroad']  do 
    require_relative './tasks/ebnf2png'
    images = EBNF.new(ebnf).images
    raise "Generated #{images.size} PNGs; expected 1" unless images.size == 1
    Tempfile.open(File.basename png, 'w') do |tempfile|
      tempfile.print images.values.first
      tempfile.close
      sh "convert png:#{tempfile.path} -trim -bordercolor White -border 10x10 #{png}"
    end
  end
end

FileList['*.html', '*.xml', '*.txt', '.htstatic', '*.jpeg'].each do |f|
  OUTPUT_FILES << (f_out = 'out/' + f)
  if %w{html xml}.any?{|e| f.end_with? e}
    file "#{f_out}.gz" => f_out do |t|
      if f_out.end_with? 'html'
        sh "h5-min #{f_out} >#{f_out}.min"
        mv "#{f_out}.min", f_out
      end
      sh "gzip --best -c #{f_out} >#{t.name}"      
    end
    OUTPUT_FILES << f_out + '.gz'
  end

  next if Rake::Task.task_defined?(f_out)
  
  if f_out.end_with?('.html')
    html_figures = []
    Nokogiri::HTML(File.read f).css('figure[@id]').map do |fig| 
      'figures/' + fig.attributes['id'].value + '.rb'
    end.select{|source_fig| File.exist?(source_fig)}.map do |source_fig|  
      html_fig = source_fig.ext('html')
      file html_fig => source_fig do
        sh "pygmentize -f html -O encoding=utf-8 -o #{html_fig} #{source_fig}"
        munged = File.read(html_fig).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                                     sub(/<\/pre><\/div>/,'</code></pre>')
        File.open(html_fig,'w') {|f| f.print munged}
      end
      html_figures << html_fig
    end

    nok = Nokogiri::HTML(File.read f)
    nok.css('figure.railroad').each do |fig|
      fig.css('img').each do |img|
        path = "out/railroad/#{img['id']}.png"
        img['id'] = ''
        img['src'] = path[4..-1]
        png = PNG.new(path)
        img['width'] = png.width.to_s
        img['height'] = png.height.to_s
      end
      File.open(f_out, 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
    end
    
    file f_out => [f, *html_figures] do |t|
      nok = Nokogiri::HTML(File.read f)
      html_figures.each do |html_fig|
        id = html_fig.match(/\/(?<id>.+)\.html/)[:id]
        nok.at("figure[@id=#{id}] > figcaption").before File.read(html_fig)
      end
      File.open(t.name, 'w'){|f| nok.write_html_to(f, encoding: 'UTF-8')}
    end
    
  else
    file f_out => f do |t|
      cp t.prerequisites.first, t.name
    end
  end
  file f_out => 'out'
  f_out
end

task :default => OUTPUT_FILES
