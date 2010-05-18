Array.class_eval do
  define_method(:second, ->{ self.[](1) })
end
[3, 4, 5].second #=> 4
