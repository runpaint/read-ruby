class Integer
  def power_of_2?
    nonzero? && (self & (self - 1)).zero?
  end
end
(0..100).select(&:power_of_2?) #=> [1, 2, 4, 8, 16, 32, 64]
