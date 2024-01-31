def findMin(self, nums) -> int:
    if len(nums) == 1:
        return nums[0]
    
    left, right = 0, len(nums)-1
    while left < right:
        mid = (left + right) // 2
        if nums[mid] > nums[mid+1] and nums[mid] > nums[mid-1]:
            return nums[mid+1]
        elif nums[mid] < nums[mid-1] and nums[mid] < nums[mid+1]:
            return nums[mid]
        elif nums[mid] > nums[mid-1] and nums[mid] < nums[mid+1]:
            if nums[mid] > nums[0] and nums[mid] > nums[len(nums) - 1]:
                left = mid
            elif nums[mid] < nums[0] and nums[mid] < nums[len(nums) - 1]:
                right = mid
            else:
                return nums[0]
