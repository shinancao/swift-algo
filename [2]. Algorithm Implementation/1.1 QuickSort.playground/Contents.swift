import Foundation
/// 递归实现的快速排序
/// 时间复杂度为O(nlogn)，极端情况下会退化为O(n^2)
/// 空间复杂度为O(1)，为原地排序
/// 因为有交换，所以不一定是稳定排序
class QuickSort {
    public static func sort(_ a: inout [Int], _ n: Int) {
        quickSorted(&a, 0, n-1)
    }
    /// 递归调用函数
    private static func quickSorted(_ a: inout [Int], _ p: Int, _ r: Int) {
        if p >= r {
            return
        }
        let q = partition(&a, p, r)
        quickSorted(&a, p, q-1)
        quickSorted(&a, q+1, r)
    }
    /// 获取分区点的index
    /// 注意，这个函数是可以修改传入的数组的，所以在获取分区点的同时就已经在排序了，直到最后一次调用，完全排序好了
    private static func partition(_ a: inout [Int], _ p: Int, _ r: Int) -> Int {
        // 拿最后一个数字作为分区点
        let pivot = a[r]
        // p ... i-1 为小于pivot，i为pivot的index，i+1 ... q为大于pivot的
        var i = p
        // 用于遍历数组
        var j = p
        while j < r {
            if a[j] < pivot {
                let tmp = a[i]
                a[i] = a[j]
                a[j] = tmp
                i += 1
            }
            j += 1
        }
        let tmp = a[i]
        a[i] = a[r]
        a[r] = tmp
        return i
    }
}

var a = [11, 8, 3, 9, 7, 1, 2, 5]
QuickSort.sort(&a, 8)
print(a)
a = [8, 10, 2, 3, 6, 1, 5]
QuickSort.sort(&a, 7)
print(a)
