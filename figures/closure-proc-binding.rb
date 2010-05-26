class Context
  @@of = :class
  def self.closure
    ->{ @@of = :method }
  end
end
eval "@@of" #=> uninitialized class variable @@of in Object (NameError)
eval "@@of", Context.closure.binding #=> :class
