currencies = {ruble: :Russia, dollar: :Fiji, euro: :Malta, zloty: :Poland}
currencies.update(dollar: :Taiwan, euro: :Spain, franc: :Switzerland)
#=> {:ruble=>:Russia, :dollar=>:Taiwan, :euro=>:Spain, 
#=>  :zloty=>:Poland, :franc=>:Switzerland}
currencies.merge(krona: :Sweden, won: :South_Korea, euro: :Italy){|currency, old, new| old}
#=> {:ruble=>:Russia, :dollar=>:Taiwan, :euro=>:Spain, :zloty=>:Poland, 
#=>  :franc=>:Switzerland, :krona=>:Sweden, :won=>:South_Korea}
