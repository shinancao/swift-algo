import Foundation
/// 要搞清楚一个数据结构，首先要搞清楚该数据结构可以用哪种方式存储，数组或链表，它都支持哪些操作。
/// 然后是时间/空间复杂度，还有适用的场合
public class Heap<T: Comparable> {
    /// 存储堆中数据，从1开始，0位置空出，以便后面索引好计算
    private var data: [T]
    /// 堆中当前的元素个数
    private var count = 0
    
    init(array: [T]) {
        precondition(array.count > 0)
        data = [T]()
        // 用来占位置0
        data.append(array[0])
        data.append(contentsOf: array)
        count = array.count
        // 将array中的元素对应成完全二叉树，则从count/2的位置开始向后都是叶子结点，所以从count/2开始逐渐向前取元素，向下找到其所属的位置
        // 该方式建队的时间复杂度是O(n)
        for i in (1 ... count/2).reversed() {
            heapify(n: count, i: i)
        }
    }
    
    /// 构造大顶堆
    /// 自下向上堆化，将待确定位置的元素放到树的最右边，也就是数组的最后，然后往上找到其合适的位置
    /// 时间复杂度O(logn)
    public func insert(_ item: T) {
        count += 1
        data.append(item)
        var i = count
        while i/2 > 0 && data[i/2] < data[i] {
            let tmp = data[i]
            data[i] = data[i/2]
            data[i/2] = tmp
            i = i/2
        }
    }
    
    public func removeMax() {
        guard count > 0 else {
            return
        }
        data[1] = data[count]
        count -= 1
        heapify(n: count, i: 1)
    }
    
    /// 把第一个元素交换到最后的位置，然后重新将最后一个元素前面的堆化O(nlogn)
    /// 排序的时间复杂度为O()
    public func sort() {
        var k = count
        while k > 1 {
            let tmp = data[1]
            data[1] = data[k]
            data[k] = tmp
            k -= 1
            heapify(n: k, i: 1)
        }
    }
    
    /// 自上向下堆化，删除堆顶元素（数组中位置为1的元素），把最后一个元素放到堆顶，然后从上往下确定该元素合适的位置
    /// 堆化的时间复杂度为O(n)
    private func heapify(n: Int, i: Int) {
        var i = i
        while true {
            var maxPos = i
            // i位置元素与其左结点比较
            if 2*i <= n && data[i] < data[2*i] {
                maxPos = 2*i
            }
            // 左结点与右结点比较
            if 2*i+1 <= n && data[2*i] < data[2*i+1] {
                maxPos = 2*i+1
            }
            // 如果maxPos没有改变，则元素已经处于合适的位置
            if maxPos == i {
                break
            }
            let tmp = data[i]
            data[i] = data[maxPos]
            data[maxPos] = tmp
            i = maxPos
        }
    }
}

extension Heap: CustomStringConvertible {
    public var description: String {
        guard count > 0 else {
            return ""
        }
        let range = 1...count
        let subArray = data[range]
        return subArray.description
    }
}

let array = [1, 2, 5, 6, 7, 8, 9, 13, 15, 16, 17, 21, 33]
let heap = Heap(array: array)
heap.insert(11)
print(heap)
heap.removeMax()
print(heap)
heap.sort()
print(heap)
