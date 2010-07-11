class Sitemap < Mustache
  include ReadRuby

  GOOD_EXT = %w{.html .png .rb}

  def urls
    Dir["#{OUT_DIR}/*", 
        "#{Example.dir}/*#{Example.target_ext}", 
        "#{Railroad.dir}/*#{Railroad.target_ext}"
    ].map{|f| Pathname f}.
      select{|f| GOOD_EXT.any?{|e| f.extname == e}}.
      reject{|f| f.fnmatch?('*google*') or f.basename.to_s == 'index.html'}.
      reject{|f| Error.dir.join(f.basename).exist? }.
      map{|f| f.dirname == OUT_DIR ? f.basename : f}.
      map{|f| {url: ROOT_URL + f.sub_ext('').to_s}}
  end
end
