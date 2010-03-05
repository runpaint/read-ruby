module Roman
  ARABIC = {'I' => 1,   'V' => 5,   'X' => 10, 'L' => 50, 
            'C' => 100, 'D' => 500, 'M' => 1000          }
  def self.const_missing(name)
    digits = [*name.to_s.upcase.chars].reverse.map{|r| ARABIC[r] or super}
    digits.map.with_index {|d,i| digits[i.zero? ? i : i-1] > d ? -d : d}.reduce(:+) 
  end
end
Roman::XLVII #=> 47
