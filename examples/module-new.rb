indeterminate = Module.new do
  def size
  end
end
indeterminate.name #=> nil
quantities = [3, 7, 11, 47]
quantities.extend(indeterminate)
quantities.size #=> nil
Indeterminate = indeterminate
indeterminate.name #=> "Indeterminate"
