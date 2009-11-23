# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
CLOBBER.include('out')
directory 'out'

rule(/figures\/.+\.html/ => '.rb') do |t|
  sh "pygmentize -f html -O encoding=utf-8 -o #{t.name} #{t.source}"
  munged = File.read(t.name).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                             sub(/<\/pre><\/div>/,'</code></pre>')
  File.open(t.name,'w'){|f| f.print munged}
end

rule(/\.html/ => FileList['figures/*.rb'].map{|f| f.sub(/rb$/, 'html')} << 'out') do |t|
  nok = Nokogiri::HTML(File.read t.name)
  has_figures = false
  nok.css('figure').each do |figure|
    id = figure.attributes['id'].value
    if file = t.prerequisites.grep(/\/#{id}.html$/).first
      # Warn if the figure has no dd or file?
      figure.at('dt').before "<dd>#{File.read file}</dd>"
      has_figures = true
    end
  end
  nok.at('title').after("<link href=pygments.css rel=stylesheet>") if has_figures
  nok.write_html_to(File.new(File.join('out', t.name), 'w'), encoding: 'UTF-8')
end

task :css => 'out' do
  Dir.glob('*.css').each{|f| cp f, 'out/'}
end

task :chapters => FileList['*.html']
task :default => [:css, :chapters]
