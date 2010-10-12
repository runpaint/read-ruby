music = {LP: :long_play, EP: :extended_play, CD: :compact_disc}
music.each.map{|k, v| "#{k} means '#{v}'"}
["LP means 'long_play'", "EP means 'extended_play'", "CD means 'compact_disc'"]
music.each_key{|acronym| print acronym}
# LPEPCD
#=> {:LP=>:long_play, :EP=>:extended_play, :CD=>:compact_disc}
