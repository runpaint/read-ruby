"Hieronymus Bosch" =~ /Ron/i    #=> 3
"Jheronimus van Aken" =~ /Ron/i #=> 3
/hero/ =~ "Jheronimus van Aken" #=> 1
/heretic/ =~ "Hieronymus Bosch" #=> nil
