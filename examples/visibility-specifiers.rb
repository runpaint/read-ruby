class C                
  # This method is public because it hasn't been specified
  # otherwise
  def pub
  end
  
  private
  # This method is private because it appears after the
  #'private' visibility specifier
  def pri
  end

  # This method is also private because the previous visibility
  # specifier has not been overridden
  def pri2
  end

  protected
  # This method is protected because it appears after the
  #'protected' visibility specifier
  def pro
  end
  
  public
  # This method is public because the protected visibility
  # specifier has been explicitly overridden. Typically this would
  # have been defined after 'pub', removing the need for a
  # visibility specifier
  def pub2
  end  
end  
