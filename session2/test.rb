def find_needle_on_haystack(find, *haystack)
  puts haystack
  if find == '|'
    puts "Here's the needle!"
  else
    print "Gotta keep searching"
    Array.new(Random.rand(5..15), '.').concat(["\n"]).each do |searching|
      print searching
    end
    find_needle_on_haystack(*haystack)
  end
end

haystack = ['~', '~', '~', '~', '~', '|', '~', '~', '~', '~', '~']
find_needle_on_haystack(*haystack.shuffle)
