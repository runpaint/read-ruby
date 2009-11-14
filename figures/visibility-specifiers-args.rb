class C                
  # The three following methods are public because they haven’t been
  # specified otherwise
  def pub
  end
  
  def pri
  end

  def pri2
  end

  # Both :pri and :pri2 are made private because their names are
  # given as arguments to the 'private' visibility specifier
  private :pri, :pri2

  # This method is also public; the preceding private keyword only
  # acts on its arguments
  def pro
  end
  # This method is made protected because its name is given to
  # the 'protected' visibility specifier
  protected 'pro'
  
  # This method is public because it hasn't been declared
  # otherwise; the previous 'protected' specifier only affects the
  # method it was called for
  def pub2
  end  
end  
