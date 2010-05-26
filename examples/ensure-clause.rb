require 'yaml'
YAML_FILE = 'tasks.yaml'
begin
  tasks = ['Water plants', 'Plant water']
  # ...
  tasks << 'Practice pentatonic scales'
  raise RuntimeError unless tasks.include?('Run 5 miles')
rescue RuntimeError
  tasks << 'Run 5 miles'
ensure
  File.open(YAML_FILE,'w') {|f| YAML.dump(tasks, f)}
end
YAML.load(File.read YAML_FILE) #=> ["Water plants", "Plant water", 
#                     "Practice pentatonic scales", "Run 5 miles"]
