 Math::PI.to_s.scan(/\d/).map(&:to_i).chunk(&:even?).map(&:last)
#=> [[3, 1], [4], [1, 5, 9], [2, 6], [5, 3, 5], [8], [9, 7, 9, 3]]
ROWS, COLS = 9, 17
grid = ROWS.times.map{ Array.new(COLS, '   ') }
(2..40).map{|n| Math.sin(n) ** 2}.chunk{|n| Math.log10(n).to_i}.each_with_index do |(log, ns), i| 
   ROWS.pred.downto(ROWS-ns.size){|row| grid[row][i] = " * "}
   (grid[ROWS] ||= []) << "%#2d " % log
end
grid.each{|row| puts row.join}
#             *                             *       
#             *                             *       
#             *                             *       
#             *                             *       
#             *                             *       
#             *                             *       
#             *                             *       
#       *     *     *     *     *     *     *     * 
# *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 
# 0 -1  0 -1  0 -1  0 -1  0 -4  0 -1  0 -1  0 -1  0 
