"\xba".unpack('h*') #=> ['ab']
"\xab".unpack('H*') #=> ['ab']
'feed me?'.unpack('a2a2a*') #=> ["fe", "ed", " me?"]
bin = 105.to_s 2    #=>  "1100101"
?K.unpack('b7')     #=> ["1101001"]
"\xD2".unpack('B7') #=> ["1101001"]
")4F5A9\"!2=6)Y\n".unpack ?u #=> ["Read Ruby"] 
"Read Ruby=\n".unpack ?M #=> ["Read Ruby"]
"UmVhZCBSdWJ5\n".unpack ?m #=> ["Read Ruby"]

mem_ptr = ['Read Ruby'].pack ?P #=> "\xA0\x9C\x12\t"
mem_ptr.unpack('P')  #=> ["R"]
mem_ptr.unpack('P*') #=> ["Read"]
mem_ptr.unpack('P8') #=> ["Read Rub"]

null_str = ['Read Ruby'].pack(?p) #=> "\x90N/\t"
null_str.unpack ?p                #=> ["Read Ruby"]
