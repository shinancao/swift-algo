import Foundation

/// 实现一个数组存储的队列
/// 当取出一个元素时，head指针像后移动，而不是移动数组中的元素向前，提高取数据的效率
public struct Queue<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard let element = array[guarded: head] else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        // 设置一定的条件，当达到时，释放数组中前面再也用不到的空间
        // 具体什么条件，可以根据项目实际情况定
        let percentage = Double(head) / Double(array.count)
        if array.count > 2 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}

// MARK: - Test Cases

var queueOfNames = Queue<String>()
queueOfNames.enqueue("Carl")
queueOfNames.enqueue("Lisa")
queueOfNames.enqueue("Stephanie")
queueOfNames.enqueue("Jeff")
print(queueOfNames.array)

queueOfNames.dequeue()
print(queueOfNames.array)
queueOfNames.dequeue()
print(queueOfNames.array)
queueOfNames.dequeue()
print(queueOfNames.array)

queueOfNames.front

queueOfNames.isEmpty
