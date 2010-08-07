# -*-Ruby-*-

require 'pathname'

# To validate locally, set the 'docbook' symlink to point to the system DocBook
# schema/stylesheet directory. On Debian and its derivatives this is
# /usr/share/xml/docbook/
DOCBOOK_RNG = 'docbook/schema/rng/5.0/docbookxi.rng'
BOOK_XML = 'book.xml'
HTML_XSL = "xsl/html5.xsl"
OUT_DIR = Pathname('out')
EX_DIR = Pathname('examples/')
PRISTINE_DIR = Pathname('www')
RSYNC_EXCLUDE = %w{*examples/*html apache.conf*}

task :validate => [:relaxng, :nvdl, :h5_valid]

task :relaxng do
  sh "xmllint --xinclude --noout --relaxng #{DOCBOOK_RNG} #{BOOK_XML} 2>&1"
end

task :nvdl do
  sh "onvdl #{BOOK_XML}"
end

task :html do
  OUT_DIR.rmtree if OUT_DIR.exist?
  cp_r PRISTINE_DIR, OUT_DIR
  sh "xsltproc --stringparam out_dir #{OUT_DIR.expand_path} " +
     "--xinclude #{HTML_XSL} #{BOOK_XML} "                    +
     " >#{IO::NULL}" 
end

task :minify => :html do
  OUT_DIR.each_child do |f|
    next unless f.extname == '.html'
    path = f.to_path
    sh "h5-min #{path} >#{path}.min"
    mv "#{path}.min", path
    sh "gzip -cn #{path} >#{path}.gz"
  end
end

task :h5_valid => :html do
  OUT_DIR.each_child do |f|
    next unless f.extname == '.html'
    next if (path = f.to_path).include?('google')
    results = `h5-valid #{f}`
    unless $?.success?
      warn "Invalid: #{f}"
      warn results
    end
  end
end

task :highlight => :html do
  require 'nokogiri'

  Pathname.glob("#{OUT_DIR}/*html").each do |html|
    nok = Nokogiri::HTML(html.read)
    next unless nok.at('code.ruby')
    nok.css('code.ruby').each do |code|
      ex = Pathname("#{EX_DIR}/#{code['id'].sub(/^ex\./,'')}.html")
      next unless ex.exist?
      code.parent.swap(ex.read)
    end
    open(html, ?w) {|f| f << nok.to_s}
  end
end

CODERAY = %Q{
  <a href=/examples/%s>
    <pre class=ruby><code>%s</code></pre>
  </a>
}

task :coderay do
  require 'coderay'

  EX_DIR.each_child do |pa|
    next unless pa.extname == '.rb'
    html = CodeRay.highlight_file(pa.to_path)
    nok = Nokogiri::HTML(html)
    open(pa.sub_ext('.html'), ?w) do |f|
      f << CODERAY % [pa.basename, nok.at('pre').inner_html]
    end
  end
end

desc 'Upload current build'
task :rsync  do
  exclude = RSYNC_EXCLUDE.map do |glob|
    "--exclude '#{glob}' "
  end.join
  sh "rsync #{exclude} --delete -vazL out/ ruby:/home/public"
end

desc 'Push to GitHub'
task :push do
  sh 'git push github'
end  

task :default => [:html, :highlight, :minify, :validate]

# TODO: Add Sinatra integration back in
