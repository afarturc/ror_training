# Solution 1

def two_sum(nums, target)
  num_indices = {}

  nums.each_with_index do |num, i|
    complement = target - num

    if num_indices.key?(complement)
      return [num_indices[complement], i]
    end

    num_indices[num] = i
  end

  []
end

nums = [2, 7, 11, 15]
target = 9
p two_sum(nums, target)
