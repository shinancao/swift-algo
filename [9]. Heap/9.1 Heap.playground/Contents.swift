import Foundation
/// 要搞清楚一个数据结构，首先要搞清楚该数据结构可以用哪种方式存储，数组或链表，它都支持哪些操作。
/// 然后是时间/空间复杂度，还有适用的场合
public class Heap<T: Comparable> {
    /// 存储堆中数据，从1开始，0位置空出，以便后面索引好计算
    private var data: [T]
    /// 堆中能存储的最大元素个数
    private var capacity = 0
    /// 堆中当前的元素个数
    private var count = 0
    
    init(defaultElement: T, capacity: Int) {
        data = [T](repeating: defaultElement, count: capacity)
    }
    
//    public convenience init(array: [T]) {
//        self.init()
//        array.forEach { (item) in
//            insert(item)
//        }
//    }
    /// 自下向上堆化，将待确定位置的元素放到树的最右边，也就是数组的最后，然后往上找到其合适的位置
    public func insert(_ item: T) {
        guard count >= capacity else {
            return
        }
        count += 1
        data[count] = item
        var i = count
        while i/2 > 0 && data[i/2] < data[i] {
            let tmp = data[i]
            data[i] = data[i/2]
            data[i/2] = tmp
            i = i/2
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

let heap = Heap(defaultElement: 0, capacity: 50)
let array = [1, 2, 5, 6, 7, 8, 9, 13, 15, 16, 17, 21, 33]
array.forEach { (item) in
    heap.insert(item)
}
print(heap)
