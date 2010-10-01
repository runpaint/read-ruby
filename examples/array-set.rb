male_names = %w{Alex Brian Chris Dave}
female_names = %w{Alex Bernice Chris Denise}
male_names - female_names
#=> ["Brian", "Dave"]
male_names & female_names
#=> ["Alex", "Chris"]
male_names | female_names 
#=> ["Alex", "Brian", "Chris", "Dave", "Bernice", "Denise"]
