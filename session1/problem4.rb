# nums = [1,2,3,4]
# output = [24,12,8,6]

# nums = [-1,1,0,-3,3]
# output = [0,0,9,0,0]

# O(n^2)
# print NUMS.map { |n| NUMS.reject { |n2| n2 == n }.inject { |mem, num| mem * num } }

# Solution 1

def product_except_self(nums)
  n = nums.length
  raise ArgumentError, "Invalid input: nums length must be between 2 and 10^5." unless n >= 2 && n <= 10**5
  nums.each do |num|
    raise ArgumentError, "Invalid input: num values must be between -30 and 30." unless num >= -30 && num <= 30
  end

  result = Array.new(n, 1)

  left_product = 1
  (0...n).each do |i|
    result[i] = left_product
    left_product *= nums[i]
  end

  right_product = 1
  (n - 1).downto(0) do |i|
    result[i] *= right_product
    right_product *= nums[i]
  end

  result
end

nums1 = [1, 2, 3, 4]
puts "Input: #{nums1}, Output: #{product_except_self(nums1)}"

nums2 = [-1, 1, 0, -3, 3]
puts "Input: #{nums2}, Output: #{product_except_self(nums2)}"
