class Object
  def send?(selector, *args, &block)
    begin
      send(selector, *args, &block)
    rescue NoMethodError
    end
  end
end
