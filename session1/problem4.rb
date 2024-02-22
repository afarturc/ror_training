# nums = [1,2,3,4]
# output = [24,12,8,6]

# nums = [-1,1,0,-3,3]
# output = [0,0,9,0,0]

=begin
# O(n^2)
NUMS = [1, 2, 3, 4]
p NUMS.map { |n| NUMS.reject { |n2| n2 == n }.inject { |mem, num| mem * num } }
=end

# Solution 1 - Prefix and Suffix O(N) Time Complexity and Auxiliary Space
def product_except_self(nums)
  n = nums.length
  prefixes = Array.new(n, 1)
  suffixes = Array.new(n, 1)

  return nil unless n >= 2 && n <= 10e5
  return nil if nums.any? { |n| n < -30 || n > 30 }

  left_product = 1
  (0...n).map do |i|
    prefixes[i] = left_product
    left_product *= nums[i]
    return nil unless is_32_bit?(left_product)
  end

  right_product = 1
  (n - 1).downto(0) do |i|
    suffixes[i] = right_product
    right_product *= nums[i]
    return nil unless is_32_bit?(right_product)
  end

  result = []
  (0...n).each do |i|
    result << prefixes[i] * suffixes[i]
  end

  result
end

def is_32_bit?(x)
  x.bit_length < 32
end

# Solution 2 - Prefix and Suffix O(N) Time Complexity and O(1) Auxiliary Space
def product_except_self2(nums)
  size = nums.length
  prod = Array.new(size, 1)

  return nil unless size >= 2 && size <= 10e5
  return nil if nums.any? { |n| n < -30 || n > 30 }

  temp = 1
  (0...size).each do |i|
    prod[i] = temp
    temp *= nums[i]
    return nil unless is_32_bit?(temp)
  end

  temp = 1
  (size - 1).downto(0) do |i|
    prod[i] *= temp
    temp *= nums[i]
    return nil unless is_32_bit?(temp)
  end

  prod
end

not_nums = [1]
nums1 = [1, 2, 3, 4]
nums2 = [-1, 1, 0, -3, 3]
nums3 = [10, 3, 5, 6, 2]

puts "Input: #{nums1}, Output: #{product_except_self(nums1)}"
puts "Input: #{nums1}, Output: #{product_except_self2(nums1)}"
puts "Input: #{nums2}, Output: #{product_except_self(nums2)}"
puts "Input: #{nums2}, Output: #{product_except_self2(nums2)}"
puts "Input: #{nums3}, Output: #{product_except_self(nums3)}"
puts "Input: #{nums3}, Output: #{product_except_self2(nums3)}"
puts "Input: #{not_nums}, Output: #{product_except_self(not_nums)}"
