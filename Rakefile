# encoding: utf-8
require 'rake/clean'
CLOBBER.include('out')
directory 'out'

task :css => 'out' do
  Dir.glob('*.css').each{|f| cp f, 'out/'}
end

task :embed_figures => ['out', :css] do
  require 'nokogiri'
  FileList['*.html'].each do |chapter|
    nok = Nokogiri::HTML(File.read chapter)
    has_figures = false
    nok.css('figure').each do |figure|
      id = figure.attributes['id'].value
      file = File.join('figures', id + '.rb')
      # Warn if the figure has no dd or file?
      next unless File.exists?(file)
      highlighted = `pygmentize -f html -O encoding=utf-8 #{file}`.
        sub(/^<div.+pre>/, '<pre class=syntax><code>').
        sub(/<\/pre><\/div>/,'</code></pre>').
        gsub(/<span class="([^"]+)">/,'<span class=\1>') #undone by Nokogiri
      figure.at('dt').after "<dd>#{highlighted}</dd>"
      has_figures = true
    end
    nok.at('title').after("<link href=pygments.css rel=stylesheet>") if has_figures
    nok.write_html_to(File.new(File.join('out', chapter), 'w'), encoding: 'UTF-8')
  end
end

task :default => :embed_figures
