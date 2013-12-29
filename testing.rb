def number_shuffle(number)
  number.to_s.split(//).permutation.to_a.map {|a| a.join.to_i }
end


print number_shuffle(1234)
