import Foundation
/// 桶排序
/// 时间复杂度O(n)
/// 其实就是用空间换了时间，所以才能达到O(n)的时间复杂度
/// 适用于外部排序，比如排序硬盘上的数据
class BucketSort {
    public static func sort(_ a: inout [Int], _ bucketSize: Int) {
        let n = a.count
        if n <= 1 {
            return
        }
        // 找到最小值和最大值，知道数据的区间后，计算出需要桶的个数
        var min = a[0]
        var max = a[0]
        for i in 1 ..< n {
            if a[i] < min {
                min = a[i]
            } else if a[i] > max {
                max = a[i]
            }
        }
        // 计算桶的个数
        let bucketCount = (max - min)/bucketSize + 1
        // 定义桶
        var buckets = [[Int]](repeating: [Int](), count: bucketCount)
        // 将数据分配到桶中
        for i in 0 ..< n {
            // 计算要放在哪个桶中
            let index = (a[i] - min)/bucketSize
            buckets[index].append(a[i])
        }
        print(buckets)
        // 对每个桶进行快速排序
        var k = 0
        for i in 0 ..< bucketCount {
            if buckets[i].count == 0 {
                continue
            }
            quickSorted(&buckets[i], 0, buckets[i].count-1)
            // 将该桶中的数依次放回原数组中
            for j in 0 ..< buckets[i].count {
                a[k] = buckets[i][j]
                k += 1
            }
        }
    }
    /// 快排的递归函数
    private static func quickSorted(_ a: inout [Int], _ p: Int, _ r: Int) {
        if p >= r {
            return
        }
        let q = partition(&a, p, r)
        quickSorted(&a, p, q-1)
        quickSorted(&a, q+1, r)
    }
    /// 获取分区点
    private static func partition(_ a: inout [Int], _ p: Int, _ r: Int) -> Int {
        let pivot = a[r]
        var i = p
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
var a = [22, 5, 11, 41, 45, 26, 29, 10, 7, 8, 30, 27, 42, 43, 40]
BucketSort.sort(&a, 10)
print(a)
