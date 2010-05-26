File.define_singleton_method(:match) do |file, pattern|
  File.read(file).match(pattern)
end
File.match('/etc/passwd',/root/) #=> #<MatchData "root">
