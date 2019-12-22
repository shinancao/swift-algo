import Foundation

extension Heap {
    public mutating func sort() -> [T] {
        for i in stride(from: (array.count - 1), through: 1, by: -1) {
            // 可以把数组看成未排序和已排好序两部分
            // 每一趟循环都可以当前堆顶的元素交换到已排好序部分的最前面
            array.swapAt(0, i)
            // 重新将堆顶到i之前的部分堆化
            shiftDown(from: 0, until: i)
        }
        
        return array
    }
}

/// 封装一个工具方法，利用堆进行排序
/// 时间复杂度：O(nlogn)
/// 原地排序，因为有交换所以不是稳定排序
public func heapSort<T>(_ a: [T], _ sort: @escaping(T, T) -> Bool) -> [T] {
    /// 当要从小到大排序时，需要构建的是大顶堆。当要从大到小排序时，需要构建的是小顶堆。
    /// 所以构建堆的sort与排序的sort是反的
    let reverseOrder = { i1, i2 in sort(i2, i1) }
    var h = Heap(array: a, sort: reverseOrder)
    return h.sort()
}
