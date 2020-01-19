import Foundation

public class Queue<T> {
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    private var head: LinkedListNode<T>?
    private var tail: LinkedListNode<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    public var front: T? {
        return head?.value
    }
    public func enqueue(_ element: T) {
        let node = LinkedListNode(value: element)
        if isEmpty {
            // 当前队列还是空的
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = node
        }
    }
    public func dequeue() -> T? {
        guard !isEmpty else { return nil }
        
        let value = head?.value
        
        head = head?.next
        if isEmpty {
            // 如果当前队列为空，tail也要置空
            tail = nil
        }
        
        return value
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while let nd = node {
            s += "\(nd.value)"
            node = nd.next
            if (node != nil) {
                s += ","
            }
        }
        s += "]"
        return s
    }
}

// MARK: - Test Cases

let queueOfNames = Queue<String>()
queueOfNames.enqueue("Carl")
queueOfNames.enqueue("Lisa")
queueOfNames.enqueue("Stephanie")
queueOfNames.enqueue("Jeff")
print(queueOfNames)

queueOfNames.dequeue()
print(queueOfNames)
queueOfNames.dequeue()
print(queueOfNames)
queueOfNames.dequeue()
print(queueOfNames)

queueOfNames.front

queueOfNames.isEmpty
