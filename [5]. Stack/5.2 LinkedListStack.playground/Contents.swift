import Foundation

public class Stack<T> {
    public class LinkedListNode<T> {
        var value: T?
        var next: LinkedListNode<T>?
        
        public init(value: T) {
            self.value = value
        }
        
        public init() {}
    }
    
    /// 用一个哨兵结点，不存在实际的值
    /// 这样在push和pop时是最简单的
    fileprivate var dummy: LinkedListNode<T>
    
    public init() {
        dummy = LinkedListNode()
    }
    
    public func push(_ element: T) {
        let node = LinkedListNode(value: element)
        node.next = dummy.next
        dummy.next = node
    }
    
    public func pop() -> T? {
        let node = dummy.next
        dummy.next = node?.next
        return node?.value
    }
    
    public var top: T? {
        if let node = dummy.next {
            return node.value
        } else {
            return nil
        }
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = dummy.next
        while let nd = node {
            s += "\(nd.value!)"
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

let stackOfNames = Stack<String>()
stackOfNames.push("Carl")
stackOfNames.push("Lisa")
stackOfNames.push("Stephanie")
stackOfNames.push("Jeff")

print(stackOfNames)

stackOfNames.pop()
print(stackOfNames)
stackOfNames.pop()
print(stackOfNames)
