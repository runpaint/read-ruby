loop do
  puts "Password: "
  password = gets.chomp
  unless [/\d/, /[A-Z]/, /[a-z]/].all?{|pat| pat =~ password}
    $stderr.puts "Passwords must contain uppercase, lowercase, and digits"
    redo
  end
  unless password.size > 8
    $stderr.puts "Passwords must be at least 9 characters long"
    redo
  end
  puts "Thanks. Confirm password: "
  unless password == gets.chomp
    $stderr.puts "The passwords entered do not match!"
    redo
  end
  break
end
