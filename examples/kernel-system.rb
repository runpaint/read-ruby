system('git init') #=> true
system(*%w{gpg -r runrun@runpaint.org --encrypt file}) #=> true
system("cat glark") #=> false
# cat: glark: No such file or directory
system("xzxzxzxz") #=> nil
