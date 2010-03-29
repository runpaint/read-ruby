String.instance_methods.include?(:try_convert) #=> false
String.method_defined?(:try_convert) #=> false
String.singleton_methods.include?(:try_convert) #=> true
String.respond_to?(:try_convert) #=> true

String.instance_methods.include?(:upcase) #=> true
String.method_defined?(:upcase) #=> true
String.singleton_methods.include?(:upcase) #=> false
String.respond_to?(:upcase) #=> false
