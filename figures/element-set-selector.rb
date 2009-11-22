tower = 'Tower of Pisa'
tower[/\w+$/] = 'Babel'
tower #=> "Tower of Babel"
tower[-5..-1] = 'London'
tower #=> "Tower of London"
tower = tower.split(//)
tower[0..4] = %w{C i t y}
tower.join #=> "City of London"
