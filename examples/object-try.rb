class Object
  alias_method :try, :__send__
end

class NilClass
  def try(*args)
    nil
  end
end
