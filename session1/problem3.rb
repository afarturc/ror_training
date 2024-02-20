# O(N) Solution 1

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

# O(N**2) - GeeksForGeeks Naive Approach
def two_sum_1(nums, target)
  size = nums.length
  (0...size).each do |i|
    ((i + 1)...size).each do |j|
      if nums[i] + nums[j] == target
        return [i, j]
      end
    end
  end
end

# O(NlogN) - GeeksForGeeks Two-pointers techique
def two_sum_2(nums, target)
  size = nums.length
  num_with_indices = nums.each_with_index.to_a
  sorted_nums_with_indices = num_with_indices.sort_by(&:first)
  l = 0
  r = size - 1

  while l < r
    sum = sorted_nums_with_indices[l][0] + sorted_nums_with_indices[r][0]
    if sum == target
      return [sorted_nums_with_indices[l][1], sorted_nums_with_indices[r][1]]
    elsif sum < target
      l += 1
    else
      r -= 1
    end
  end

  nil
end

nums = [2, 15, 11, 7]
target = 9
p two_sum(nums, target)
p two_sum_1(nums, target)
p two_sum_2(nums, target)
