module ISBN
  module_function
  # Convert ISBN-13 to ISBN-10
  def thirteen_to_ten(isbn)
    csum = checksum10(isbn = isbn.to_s[3,9])
    isbn + ({10 => 'X', 11 => '0'}[csum] || csum.to_s)
  end

  private
  def checksum10(isbn, weight=11)
    11 - isbn.chars.reduce(0){|mem,c| mem + (c.to_i * weight -= 1)} % 11
  end
end

isbns = {'9780596529260' => '0596529260', 
         '9780596102432' => '0596102437', 
         '9780596007591' => '0596007590'}
isbns.all?{|thirteen, ten| ISBN.thirteen_to_ten(thirteen) == ten}
#=> `thirteen_to_ten': undefined method `checksum10' for ISBN:Module (NoMethodError)
