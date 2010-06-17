# coding: utf-8
%q@
Subject: Are You Our Missing Winner?
To: %{email}

Dear %{name},
Congratulations! You have been selected to receive a cash prize 
of £%.2<prize>f!!! Your name was selected at random by our 
supercomputer to be a millionaire!?! But hurry, you must claim 
your fortune by **%.19<deadline>p** or it will be gifted 
to the next name on our shortlist.

Hurry. Please act now.
@ % {name: 'A. Patsy', prize: 2_883_712.28271, email: 'mark@aol.com',
     deadline: Time.now.utc + (60+24*3600)}
#=>
#Subject: Are You Our Missing Winner?
#To: mark@aol.com
#
#Dear A. Patsy,
#Congratulations! You have been selected to receive a cash prize 
#of £2883712.28!!! Your name was selected at random by our 
#supercomputer to be a millionaire!?! But hurry, you must claim 
#your fortune by **2010-06-18 22:23:52** or it will be gifted 
#to the next name on our shortlist.
#
#Hurry. Please act now.
