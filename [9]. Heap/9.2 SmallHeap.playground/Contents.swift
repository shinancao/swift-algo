import Foundation

public class Heap<T: Comparable> {
    private var data: [T]
    private var count = 0
    
    init(array: [T]) {
        precondition(array.count > 0)
        data = [T]()
        data.append(array[0])
        data.append(contentsOf: array)
        count = array.count
        for i in (1 ... count/2).reversed() {
            heapify(n: count, i: i)
        }
    }
    
    private func heapify(n: Int, i: Int) {
        var i = i
        while true {
            var minPos = i
            if 2*i <= n && data[i] > data[2*i] {
                minPos = 2*i
            }
            if 2*i+1 <= n && data[2*i] > data[2*i+1] {
                minPos = 2*i+1
            }
            if minPos == i {
                break
            }
            let tmp = data[i]
            data[i] = data[minPos]
            data[minPos] = tmp
            i = minPos
        }
    }
    
    public func insert(_ item: T) {
        count += 1
        data.append(item)
        var i = count
        while i/2 > 0 && data[i/2] > data[i] {
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

let heap = Heap(array: [1, 2, 21, 6, 33, 8, 9, 13, 7, 16, 17, 15, 33])
print(heap)
heap.insert(5)
print(heap)
