class Sitemap < Mustache
  include ReadRuby

  BAD_EXT = %w{.css .js .xml}

  def urls
    Dir["#{OUT_DIR}/*", 
        "#{Example.dir}/*#{Example.target_ext}", 
        "#{Railroad.dir}/*#{Railroad.target_ext}"
       ].map{|f| Pathname f}.
         reject(&:directory?).
         reject{|f| BAD_EXT.any?{|e| f.extname == e} or f.fnmatch?('*google*')}.
         map{|f| f.dirname == OUT_DIR ? f.basename : f}.
         map{|f| {url: ROOT_URL + f.sub_ext('').to_s}}
  end
end
