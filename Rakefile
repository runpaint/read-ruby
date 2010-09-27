# -*-Ruby-*-

require 'pathname'
require 'nokogiri'

BOOK_XML = 'book.xml'

namespace :xml do
  # To validate locally, set the 'docbook' symlink to point to the system DocBook
  # schema/stylesheet directory. On Debian and its derivatives this is
  # /usr/share/xml/docbook/
  DOCBOOK_RNG = 'docbook/schema/rng/5.0/docbookxi.rng'

  desc "Validate the XML with RelaxNG"
  task :relaxng do
    sh "xmllint --xinclude --noout --relaxng #{DOCBOOK_RNG} #{BOOK_XML} 2>&1"
  end

  desc "Validate the XML with NVDL"
  task :nvdl do
    sh "onvdl #{BOOK_XML}"
  end

  desc "Validate the XML with RelaxNG and NVDL"
  task :validate => [:relaxng, :nvdl]
end

namespace :html do
  HTML_XSL = "xsl/html5.xsl"
  OUT_DIR = Pathname('out')
  EX_DIR = Pathname('examples/')
  PRISTINE_DIR = Pathname('www')

  desc "Transform the XML into HTML"
  task :generate do
    OUT_DIR.rmtree if OUT_DIR.exist?
    cp_r PRISTINE_DIR, OUT_DIR
    sh "xsltproc --stringparam out_dir #{OUT_DIR.expand_path} " +
      "--xinclude #{HTML_XSL} #{BOOK_XML} "                    +
      " >#{IO::NULL}" 
  end

  desc "Minify the HTML"
  task :minify => :generate do
    OUT_DIR.each_child do |f|
      next unless f.extname == '.html'
      path = f.to_path
      sh "h5-min #{path} >#{path}.min"
      mv "#{path}.min", path
      sh "gzip -cn #{path} >#{path}.gz"
    end
  end

  desc "Validate the HTML"
  task :validate => :generate do
    ok = true
    OUT_DIR.each_child do |f|
      next unless f.extname == '.html'
      next if (path = f.to_path).include?('google')
      results = `h5-valid #{f}`
      unless $?.success?
        warn "Invalid: #{f}"
        warn results
        ok = false
      end
    end
    abort "Invalid HTML" unless ok
  end

  desc "Replace examples with highlighted versions"
  task :highlight => :generate do
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

  desc "Rebuild the highlighted examples"
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

  desc "Generate the HTML, highlight examples, then minify"
  task :build => [:generate, :highlight, :minify]
end

namespace :web do
  RSYNC_EXCLUDE = %w{*examples/*html *examples/.*}

  desc 'View locally with a web browser'
  task :browse do
    sh "./bin/browse #{OUT_DIR}"
  end

  desc 'Upload current build'
  task :rsync  do
    exclude = RSYNC_EXCLUDE.map do |glob|
      "--exclude '#{glob}' "
    end.join
    sh "rsync #{exclude} --delete -vazL out/ ruby:/home/public"
  end
end

desc 'Push to GitHub'
task :push do
  sh 'git push github'
end  

desc 'Validate XML, build HTML, validate HTML'
task :build => %w{xml:validate html:build html:validate}
task :default => :build

desc "Rebuild then rsync"
task :upload => %w{build push web:rsync}
