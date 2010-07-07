require_relative 'lib/read-ruby'
include ReadRuby

RSYNC_EXCLUDE = %w{*examples/*html apache.conf*}
MINIFIER = {html: 'h5-min', css: 'yuicompressor', js: 'yuicompressor'}

task :default => :html

desc 'Rebuild HTML, CSS, and JS'
task :html do
  OUT_DIR.rmtree if OUT_DIR.exist?
  cp_r PRISTINE_DIR, OUT_DIR
  OUT_DIR.each_child do |file|
    next unless file.symlink?
    target, name = OUT_DIR.join(file.readlink), file
    next unless target.extname == TEMPLATE_EXT
    template = target.sub_ext('').basename.to_s
    rendered = begin
      Object.const_get(template.capitalize).new(name).tap do |o|
        o.fixup if o.respond_to?(:fixup)
      end.render
    rescue NameError => e
      Mustache.render(target.read)
    end
    name.unlink
    open(name, ?w){|f| f.print rendered}
  end
end

desc 'Minify HTML, CSS, and JS'
task :minify do
  OUT_DIR.each_child.select(&:file?).each do |file|
    if min = MINIFIER[ :"#{file.extname[1..-1]}" ]
      sh "#{min} #{file} > #{file}.min"
      mv "#{file}.min", file
    end
    sh "gzip --best -cn #{file} > #{file}.gz"
  end
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
