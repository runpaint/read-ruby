cubes = [1.0]
cubes.push cubes.first * 8, Math.log2 134217728, 64.0
#=> SyntaxError: syntax error, unexpected tINTEGER, expecting $end
#   cubes.push cubes.first * 8, Math.log2 134217728, 64.0
#                                                  ^
cubes.push cubes.first * 8, Math.log2(134217728), 64.0
#=> [1.0, 8.0, 27.0, 64.0]
