import Foundation

class Sort {
    /// 插入排序
    /// 时间复杂度O(n^2)
    /// 空间复杂度O(1)，是原地排序
    /// 是稳定排序
    public static func insertionSort(_ a: inout [Int], _ n: Int) {
        if n <= 1 {
            return
        }
        // 可以将数组分成有序区间和无序区间，初始时有序区间只有一个元素
        // 此后依次从无序区间取第一个元素value插入到有序区间中
        // 像前遍历有序区间，逐步向后移动元素，直到找到合适value的插入位置
        for i in 1 ..< n {
            let value = a[i]
            var j = i - 1
            while j >= 0 {
                if a[j] > value {
                    a[j+1] = a[j]
                    j -= 1
                } else {
                    break
                }
            }
            a[j+1] = value
        }
    }
    /// 冒泡排序
    /// 时间复杂度O(n^2)
    /// 空间复杂度O(1)，是原地排序
    /// 是稳定排序
    public static func bubbleSort(_ a: inout [Int], _ n: Int) {
        if n <= 1 {
            return
        }
        var i = n - 1
        // 每一次将相邻的两个数进行比较，前者大于后者则交换，每走完一次总会有一个数到了它应该在的位置
        // 当一趟比较的过程中没有需要交换时，则数组已排好序
        while i >= 0 {
            // 标识是否有数据交换，如果没有则可以提前退出
            var flag = false
            for j in 0 ..< i {
                if a[j+1] < a[j] {
                    let tmp = a[j+1]
                    a[j+1] = a[j]
                    a[j] = tmp
                    flag = true
                }
            }
            i -= 1
            if !flag {
                break
            }
        }
    }
    /// 选择排序
    /// 时间复杂度O(n^2)
    /// 空间复杂度O(1)，是原地排序
    /// 不是稳定排序
    public static func selectionSort(_ a: inout [Int], _ n: Int) {
        if n <= 1 {
            return
        }
        for i in 0 ..< n-1 {
            // 每次从i后面开始找到最小的元素的index，将其换到i的位置
            var minIndex = i
            for j in i+1 ..< n {
                if a[j] < a[minIndex] {
                    minIndex = j
                }
            }
            // 交换a[i]和a[minIndex]
            let tmp = a[i]
            a[i] = a[minIndex]
            a[minIndex] = tmp
        }
    }
}

var a = [4, 5, 7, 1, 7, 2]
Sort.insertionSort(&a, 6)
print(a)
a = [4, 5, 6, 3, 2, 1]
Sort.bubbleSort(&a, 6)
print(a)
a = [4, 5, 6, 8, 11, 3, 2, 1]
Sort.selectionSort(&a, 8)
print(a)
