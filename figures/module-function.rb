module ISBN
  module_function
  # Convert ISBN-13 to ISBN-10
  def thirteen_to_ten(isbn)
    isbn, weight = isbn.to_s[3,9].chars, 11
    csum = 11 - isbn.reduce(0){|mem,c| mem + (c.to_i * weight -= 1)} % 11
    isbn.join + ({10 => 'X', 11 => '0'}[csum] || csum.to_s)
  end
end

isbns = {'9780596529260' => '0596529260', 
         '9780596102432' => '0596102437', 
         '9780596007591' => '0596007590'}
isbns.all?{|thirteen, ten| ISBN.thirteen_to_ten(thirteen) == ten} #=> true
include ISBN
isbns.all?{|thirteen, ten| thirteen_to_ten(thirteen) == ten} #=> true
