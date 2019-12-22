import Foundation

public class TopKLargest<T: Comparable> {
    var minHeap: Heap<T>
    var k: Int
    
    public init(k: Int) {
        self.k = k
        minHeap = Heap(sort: <)
    }
    
    public var elements: [T] {
        return minHeap.array
    }
    
    public func insert(_ value: T) {
        guard minHeap.count == k else {
            minHeap.insert(value)
            return
        }
        
        if let top = minHeap.peek, top < value {
            minHeap.replace(index: 0, value: value)
        }
    }
}
