import UIKit
/**
 88. 合并两个有序数组
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。
 
 说明:
 
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
 示例:
 
 输入:
 nums1 = [1,2,3,0,0,0], m = 3
 nums2 = [2,5,6],       n = 3
 
 输出: [1,2,2,3,5,6]
 */

var nums1 = [1,2,3,0,0,0]
let nums2 = [2,5,6]

/// 从头扫面两个数组
class Solution1 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // 将nums1拷贝到新数组中
        var nums1_copy = [Int]()
        nums1_copy.append(contentsOf: nums1)
        // 定义指针，分别指向nums1、nums2、nums1_copy
        var p = 0
        var p1 = 0
        var p2 = 0
        // 移动指针，比较大小，较小的放入新数组中
        while (p1 < n) && (p2 < m) {
            if nums2[p1] < nums1_copy[p2] {
                nums1[p] = nums2[p1]
                p1 += 1
            } else {
                nums1[p] = nums1_copy[p2]
                p2 += 1
            }
            p += 1
        }
        // 将剩余的部分放到数组中
        if p1 < n {
            nums1.insert(contentsOf: nums2[p1 ..< n], at: p)
        }
        if p2 < m {
            nums1.insert(contentsOf: nums1_copy[p2 ..< m], at: p)
        }
        // 去掉nums1中的剩余空间
        nums1.removeSubrange(m + n ..< nums1.count)
    }
}

//let solution1 = Solution1()
//solution1.merge(&nums1, 3, nums2, 3)
//print("\(nums1)")

/// 从尾扫描两个数组
class Solution2 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // 定义指针，分别指向nums1、nums2的最后一个元素位置
        var p1 = m - 1
        var p2 = n - 1
        // 定义指针，指向nums1合并后的最后一个元素位置
        var p = m + n - 1
        // 移动指针，比较大小，大的放入nums1的后面
        while p1 >= 0 && p2 >= 0 {
            if nums1[p1] > nums2[p2] {
                nums1[p] = nums1[p1]
                p1 -= 1
            } else {
                nums1[p] = nums2[p2]
                p2 -= 1
            }
            p -= 1
        }
        // 将nums2中剩余的放到nums1的前面
        if p2 >= 0 {
            for i in 0 ... p2 {
                nums1[i] = nums2[i]
            }
        }
    }
}

let solution2 = Solution2()
solution2.merge(&nums1, 1, nums2, 5)
print("\(nums1)")
