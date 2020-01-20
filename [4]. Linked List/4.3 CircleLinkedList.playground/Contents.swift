import Foundation
/// 实现一个循环链表，尾结点的next指向头结点
/// 各种操作需要额外注意处理等于tail的情况，否则容易写出死循环
public class LinkedList<T> {
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    private(set) var head: Node?
    private(set) var tail: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var count: Int {
        var node = head
        var count = 0
        while let nd = node {
            count += 1
            if node === tail {
                break
            }
            node = nd.next
        }
        return count
    }
    
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    public func node(at index: Int) -> Node {
        precondition(!isEmpty, "List is empty")
        precondition(index >= 0, "index must be greater than 0")
        
        var node = head
        var num = 0
        while let nd = node {
            if index == num {
                break
            }
            
            if nd === tail {
                node = nil
                break
            }
            node = nd.next
            num += 1
        }
        
        precondition(node != nil, "index is out of bounds")
        return node!
    }
    public func append(_ value: T) {
        let node = Node(value: value)
        append(node)
    }
    public func append(_ node: Node) {
        if let tail = tail {
            tail.next = node
        } else {
            head = node
        }
        tail = node
        tail?.next = head
    }
    public func append(_ list: LinkedList) {
        var node = list.head
        while let nd = node {
            append(nd.value)
            node = nd.next
        }
    }
    public func insert(_ value: T, at index: Int) {
        let newNode = Node(value: value)
        insert(newNode, at: index)
    }
    /// 插入的时候通过node(at: index - 1)得到前面的结点，所以index == 0时要特殊处理
    public func insert(_ newNode: Node, at index: Int) {
        if index == 0 {
            newNode.next = head
            head = newNode
            tail?.next = head
        } else {
            let prev = node(at: index - 1)
            let next = prev.next
            newNode.next = next
            prev.next = newNode
        }
    }
    public func remove(at index: Int) -> T {
        let node = self.node(at: index)
        remove(node)
        return node.value
    }
    /// 移除结点的时候，需要找到结点前面的结点，所以需要遍历
    public func remove(_ node: Node) -> T {
        // 头结点特殊处理
        if head === node {
            head = node.next
            tail?.next = head
        } else {
            // next指向的结点是要找的结点
            var prev = head
            var next = head?.next
            while let nd = next {
                if nd === node {
                    prev?.next = nd.next
                    // 如果删除的是尾结点，要重置tail
                    if nd === tail {
                        tail = prev
                    }
                    break
                }
                prev = nd
                next = nd.next
            }
        }
        
        node.next = nil
        return node.value
    }
    public func removeAll() {
        head = nil
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while let nd = node {
            s += "\(nd.value)"
            if nd === tail {
                break
            }
            s += ", "
            node = nd.next
        }
        return s + "]"
    }
}

// MARK: - Test Cases

let list = LinkedList<String>()
list.isEmpty
list.head
list.tail
list.count

list.append("Hello")
list.isEmpty
list.head!.value
list.tail!.value
list.count

list.append("World")
list.isEmpty
list.head!.value
list.tail!.value
list.count

list.insert("Goodbye", at: 0)
list.head!.value
list.tail!.value

list.remove(at: 0)
list.head!.value
list.tail!.value

list.append("Swift")
list.head!.value
list.tail!.value
list.count

print(list)
//list.remove(at: 3)
list.remove(at: 2)
list.head!.value
list.tail!.value
print(list)
