require_relative 'lib/read-ruby'
include ReadRuby

RSYNC_EXCLUDE = %w{*examples/*html apache.conf*}
MINIFIER = {html: 'h5-min', css: 'yuicompressor', js: 'yuicompressor'}

task :default => :html

desc 'Rebuild HTML, CSS, and JS'
task :html do
  OUT_DIR.rmtree if OUT_DIR.exist?
  cp_r PRISTINE_DIR, OUT_DIR
  Pathname.glob("#{OUT_DIR}/**/*").select(&:symlink?).each do |file|
    target, name = OUT_DIR.join(file.readlink), file
    next unless target.extname == TEMPLATE_EXT
    template = target.sub_ext('').basename.to_s
    rendered = begin
      Object.const_get(template.capitalize).new(name).tap do |o|
        o.fixup if o.respond_to?(:fixup)
      end.render
    rescue NameError => e
      Mustache.render(OUT_DIR.join(target).read)
    end
    name.unlink
    open(name, ?w){|f| f.print rendered}
  end
end

def minify ext
  OUT_DIR.find do |file|
    next unless file.file? and ext.include?(file.extname[1..-1])
    if min = MINIFIER[ :"#{file.extname[1..-1]}" ]
      sh "#{min} #{file} > #{file}.min"
      mv "#{file}.min", file
    end
    sh "gzip --best -cn #{file} > #{file}.gz"
  end
end

desc 'Minify HTML, CSS, and JS'
task :minify do
  minify %w{js css}
  Rake::Task[:inline].invoke
  minify %w{html xml}
end

[Example, Railroad].each do |klass|
  name = klass.to_s.downcase + 's'
  desc "Rebuild #{name}"
  task name.to_sym do
    klass.each do |source|
      file klass.target(source) => source do
        klass.generate source
      end.invoke
    end
  end
end

desc 'Push to GitHub'
task :push do
  sh 'git push github'
end

desc 'Rebuild everything & minify'
task :all => [:examples, :railroads, :html, :minify]

desc 'Rebuild everything then upload'
task :upload => [:push, :all, :rsync]

desc 'Upload current build'
task :rsync  do
  exclude = RSYNC_EXCLUDE.map do |glob|
    "--exclude '#{glob}' "
  end.join
  sh "rsync #{exclude} --delete -vazL out/ ruby:/home/public"
end

desc 'Start webserver to browse locally'
task :browse do
  system './lib/read-ruby/browse.rb'
end

desc 'Inline CSS'
task :inline do
  OUT_DIR.each_child.select(&:file?).each do |file|
    if file.extname[1..-1] == 'html'
      nok = Nokogiri::HTML(file.read)
      nok.search('link[@rel=stylesheet]').each do |link|
        next unless link['href'].start_with?(?/)
        css = (OUT_DIR + (link['href'][1..-1] << '.css')).read
        link.swap("<style>#{css}</style>")
      end
      open(file, ?w){|f| f.print nok.to_s}
    end
  end
end
