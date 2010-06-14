Dir.chdir('/tmp/animals') do
  Dir.entries(?.) #=> ["..", "."]
  Dir.mkdir('extinct')
  %w{ants hippopotamus elephants arachnids koalas accounts.csv 
     accounts.csv.bak visitors.log rota-2010 extinct/velociraptor 
     extinct/quagga extinct/aurochs extinct/dodo}.each{|file| open(file, ?w){} }        
  Dir.glob('*ants') #=> ["elephants", "ants"]
  Dir.glob('rota-????') #=> ["rota-2010"]
  Dir.glob('a*s') #=> ["ants", "arachnids"]
  Dir.glob('**/a*s') #=> ["ants", "arachnids", "extinct/aurochs"] 
  Dir.glob('extinct/*o[dc]*') #=> ["extinct/aurochs", "extinct/dodo", "extinct/velociraptor"]
  Dir.glob('{*.*,rota-201[0-9]}') 
  #=> ["accounts.csv", "accounts.csv.bak", "visitors.log", "rota-2010"]
end
