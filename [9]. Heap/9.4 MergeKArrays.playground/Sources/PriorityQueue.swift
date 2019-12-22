import Foundation

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
