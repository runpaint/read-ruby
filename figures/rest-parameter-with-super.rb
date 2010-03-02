class Parent
  def do_chores(*chores)
  end
end

class Child < Parent
  def do_chores(*)
    # our processing
    super
  end
end
