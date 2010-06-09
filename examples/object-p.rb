killed_by = {
  'Augustus' => nil,
  'Tiberius' => nil ,
  'Caligula' => {who: 'Praetorian Guard'},
  'Claudius' => {who: 'wife'},
  'Nero'     => {who: 'himself'}               
}
killed_by['Nero'][:who] = killed_by['Nero']
p killed_by.select{|*, killer| killer}
# Writes to $stdout:
# {"Caligula"=>{:who=>"Praetorian Guard"}, "Claudius"=>{:who=>"wife"}, "Nero"=>{:who=>{...}}}
