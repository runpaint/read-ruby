class Example
  extend ReadRuby
  dir 'examples'
  source_ext 'rb'
  target_ext 'html'

  def self.generate from
    to = target from
    sh "pygmentize -f html -O encoding=utf-8 -o #{to} #{from}"
    munged = File.read(to).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                           sub(/<\/pre><\/div>/,'</code></pre>')
    open(to, ?w){|f| f.print %{<a href=/#{from.sub_ext ''}>#{munged}</a>}}
  end
end
