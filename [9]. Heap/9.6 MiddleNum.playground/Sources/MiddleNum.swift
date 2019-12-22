import Foundation

public class MiddleNum<T: Comparable> {
    var maxHeap: Heap<T>
    var minHeap: Heap<T>
    
    public init(array: [T]) {
        maxHeap = Heap(sort: >)
        minHeap = Heap(sort: <)
        configureHeaps(from: array)
    }
    
    private func configureHeaps(from array: [T]) {
        for i in stride(from: 0, to: array.count, by: 1) {
            insert(array[i])
        }
    }
    
    public var midNum: T? {
        return maxHeap.peek
    }
    
    public func insert(_ value: T) {
        guard let maxHeapTop = maxHeap.peek else {
            maxHeap.insert(value)
            return
        }
        guard let _ = minHeap.peek else {
            minHeap.insert(value)
            return
        }
        
        if value <= maxHeapTop {
            maxHeap.insert(value)
        } else {
            minHeap.insert(value)
        }
        
        // 调整以保持大顶堆中的元素个数为n/2或n/2+1，小顶堆中的元素个数为n/2
        let diff = maxHeap.count - minHeap.count
        if diff < 0 {
            let top = minHeap.removeRoot()
            maxHeap.insert(top!)
        } else if diff > 1 {
            let top = maxHeap.removeRoot()
            minHeap.insert(top!)
        }
    }
}
