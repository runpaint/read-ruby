latin = "Tu ne cede malis, sed contra audentior ito"
char_string = latin.to_enum(:each_char)
vowels, consonants = char_string.partition{|char| char =~ /[aeiou]/}
vowels #=> 
# ["u", "e", "e", "e", "a", "i", "e", "o", "a", "a", "u", "e", "i", "o", "i", "o"]
