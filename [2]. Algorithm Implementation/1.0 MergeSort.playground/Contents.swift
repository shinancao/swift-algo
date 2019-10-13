import Foundation
/// 递归实现的归并排序
/// 最坏、h最好、平均时间复杂度都是O(nlogn)
/// 空间复杂度O(n)，并不是原地排序
/// 是稳定排序
class MergeSort {
    public static func sort(_ a: inout [Int], _ n: Int) {
        mergeSorted(&a, 0, n-1)
    }
    
    /// 递归调用函数，可以看成用于排序某个区间
    /// - parameter a: 要排序的数组
    /// - parameter p: 区间开始的位置
    /// - parameter r: 区间结束的位置
    private static func mergeSorted(_ a: inout [Int], _ p: Int, _ r: Int) {
        // 递归终止条件，无论何时写递归函数先考虑递归的终止条件
        if p >= r {
            return
        }
        
        // 再次分解，求中间位置
        let q = (p + r) / 2
        // 排p到q区间
        mergeSorted(&a, p, q)
        // 排q+1到r区间
        mergeSorted(&a, q+1, r)
        // 然后排p到r区间
        mergeByDummy(&a, p, q, r)
    }
    
    /// 该函数就是合并两个有序数组为一个有序数组，在数组的部分单独做过
    private static func merge(_ a: inout [Int], _ p: Int, _ q: Int, _ r: Int) {
        var tmp = [Int]()
        var i = p
        var j = q + 1
        while i <= q && j <= r {
            if a[i] < a[j] {
                tmp.append(a[i])
                i += 1
            } else {
                tmp.append(a[j])
                j += 1
            }
        }
        // 剩余部分一次性添加到tmp后面
        if i <= q {
            tmp.append(contentsOf: a[i ... q])
        }
        if j <= r {
            tmp.append(contentsOf: a[j ... r])
        }
        // 将tmp拷贝到原数组的p到r区间
        for i in p ... r {
            // 注意此处的下标取值i-p
            a[i] = tmp[i-p]
        }
    }
    
    /// 利用哨兵来实现合并两个有序数组
    private static func mergeByDummy(_ a: inout [Int], _ p: Int, _ q: Int, _ r: Int) {
        // 将a拆分成两个数组，每个数组多分配一个空间，在最后放哨兵，哨兵取无限大
        var leftArr = [Int]()
        // 千万注意！leftArr = a[p ... q] 在Swift中这样给数组赋值是不可以的！
        leftArr.append(contentsOf: a[p ... q])
        leftArr.append(Int.max)
        var rightArr = [Int]()
        rightArr.append(contentsOf: a[q+1 ... r])
        rightArr.append(Int.max)
        // 指向leftArr
        var i = 0
        // 指向rightArr
        var j = 0
        // 指向a
        var k = p
        leftArr[0]
        // 循环比较，因为两个数组最终都会到最大值处停止，所以最后不会有剩余
        while k <= r {
            if leftArr[i] < rightArr[j] {
                a[k] = leftArr[i]
                i += 1
            } else {
                a[k] = rightArr[j]
                j += 1
            }
            k += 1
        }
    }
}

var a = [11, 8, 3, 9, 7, 1, 2, 5]
MergeSort.sort(&a, 8)
print(a)
