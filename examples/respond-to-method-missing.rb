object = Object.new
def object.method_missing(selector)
  selector == :colour ? :red : super
end
object.respond_to? :colour #=> false
object.colour #=> :red
