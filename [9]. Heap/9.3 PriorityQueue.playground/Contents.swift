import Foundation
/*:
 实现一个优先级队列通常有以下几种方式：
 
 * 使用一个`有序数组`，但是效率低，因为当插入元素时仍要保持整个数组有序。
 * 使用一个`平衡二叉查找树`，可以用它来实现双端优先级队列，因为能快速地找到`最大值`和`最小值`。
 * 使用一个`堆`，其实就是可以把堆看成是优先级队列，因为它只要保持局部有序即可，所以会更加高效，堆中的所有操作的时间复杂度都是O(logn)。
 */

/// 利用堆实现一个优先级队列
public struct PriorityQueue<T> {
    fileprivate var heap: Heap<T>
    
    public init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(sort: sort)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var count: Int {
        return heap.count
    }
    
    public var peek: T? {
        return heap.peek
    }
    
    public mutating func enqueue(value: T) {
        heap.insert(value)
    }
    
    public mutating func dequeue() -> T? {
        return heap.removeRoot()
    }
    
    public mutating func changePriority(index: Int, value: T) {
        return heap.replace(index: index, value: value)
    }
}

extension PriorityQueue: CustomStringConvertible {
    public var description: String {
        return heap.description
    }
}

let array = [1, 2, 6, 15, 17, 21, 23, 33, 7, 8, 9, 13, 16, 5, 10, 12, 14]
var queue = PriorityQueue<Int>(sort: >)
array.forEach { (i) in
    queue.enqueue(value: i)
}
print(queue)
for _ in 0 ..< array.count {
    let top = queue.dequeue()!
    print(top)
}

