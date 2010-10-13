gods = %w{Aphrodite Demeter Ares Eros   Apollo   Hades  Dionysus 
          Artemis   Zeus    Hera Hermes Poseidon Athena Hestia Hephaestus}
gods.sort #=>["Aphrodite", "Apollo", "Ares", "Artemis", "Athena", "Demeter", "Dionysus", 
#=>           "Eros", "Hades", "Hephaestus", "Hera", "Hermes", "Hestia", "Poseidon", "Zeus"]
gods.sort{|a, b| a.length <=> b.length}
#=> ["Hera", "Zeus", "Ares", "Eros", "Hades", "Apollo", "Hermes", "Athena", "Hestia", 
#=>  "Demeter", "Artemis", "Poseidon", "Dionysus", "Aphrodite", "Hephaestus"]
Hash[*gods.zip(%w{f f m m m m m f m f m m f f m}).flatten].sort_by(&:reverse).map(&:first)
#=> ["Aphrodite", "Artemis", "Athena", "Demeter", "Hera", "Hestia", "Apollo", "Ares", 
#=>  "Dionysus", "Eros", "Hades", "Hephaestus", "Hermes", "Poseidon", "Zeus"]
class String
  def <=>(o)
    reverse.ord <=> o.reverse.ord
  end
end
gods.sort #=> ["Hera", "Hestia", "Athena", "Aphrodite", "Poseidon", "Apollo", "Demeter", 
#=>            "Artemis", "Zeus", "Dionysus", "Hermes", "Hades", "Eros", "Ares", "Hephaestus"]
