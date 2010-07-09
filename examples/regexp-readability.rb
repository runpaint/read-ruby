# coding: utf-8
# A naïve pattern to match a human name
title = /(?:(?<title>Mrs?|M(?:aster|s)|Dr|Sir)[[:blank:]])?/
name_part = /[[:upper:]][[:alpha:]-]+ # Double-barrelled names are allowed, but
                                      # names can't start or end with hyphens
             [[:alpha:]] # i.e. names must contain at least three characters
            /x
name_mid_part = /(?:
  (?:
    (?:[[:lower:]]{1,3})| # e.g. 'von', 'y', or 'de'
    (?:[[:upper:]]\.)   | # middle initial
    (?:#{name_part})      
  )[[:blank:]])/x
name = /(?<name>#{name_part}[[:blank:]]   # A forename
         #{name_mid_part}* # Any number of middle names
         #{name_part} # A surname or family name
        )/x             
suffix = /(?:[[:blank:]](?<suffix>[JS]r\.|[IVX]+(?# Roman numerals)))?/
full_name = /\A#{title}#{name}#{suffix}\Z/           
['Mr Harvey Duchamp II', 'Dr Ludwig von Mises', 'William S. Burroughs',
 'Ms Henrietta Cartwright-Stevens', 'Paul Erdős', 'Anonymous', '2 by 4',
 'Master Elijah Humphrey Pennington Hargreeves Jr.'].grep full_name 
#=> ["Mr Harvey Duchamp II", "Dr Ludwig von Mises", "William S. Burroughs", 
#    "Ms Henrietta Cartwright-Stevens", "Paul Erdős", 
#    "Master Elijah Humphrey Pennington Hargreeves Jr."]
