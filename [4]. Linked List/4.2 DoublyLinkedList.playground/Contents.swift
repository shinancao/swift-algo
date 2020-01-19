import Foundation

/// 实现一个双向非循环链表
public final class LinkedList<T> {
    /// 定义链表中的结点结构
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        /// 指向前面的结点
        weak var prev: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    private(set) var head: Node?
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public init() {}
    
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    
    public func node(at index: Int) -> Node {
        precondition(!isEmpty, "List is empty")
        precondition(index >= 0, "index must be greater than 0")
        
        var node = head
        // 用来计数已经遍历过的结点个数
        var num = 0
        while let nd = node {
            if (index == num) {
                break
            }
            num += 1
            node = nd.next
        }
        
        precondition(node != nil, "index is out of bounds.")
        return node!
    }
    
    public func append(_ value: T) {
        let node = LinkedListNode(value: value)
        append(node)
    }
    public func append(_ node: Node) {
        // 插在链表的最后
        let newNode = node
        if let lastNode = last {
            lastNode.next = newNode
            newNode.prev = lastNode
        } else {
            head = newNode
        }
    }
    public func append(_ list: LinkedList) {
        // 取list中的每一个值，构造node，再插入到当前链表中
        var node = list.head
        while let nd = node {
            append(nd.value)
            node = nd.next
        }
    }
    public func insert(_ value: T, at index: Int) {
        let newNode = LinkedListNode(value: value)
        insert(newNode, at: index)
    }
    public func insert(_ newNode: Node, at index: Int) {
        if index == 0 {
            newNode.next = head
            head?.prev = newNode
            head = newNode
        } else {
            let prev = node(at: index - 1)
            let next = prev.next
            newNode.prev = prev
            newNode.next = next
            prev.next = newNode
            next?.prev = newNode
            
        }
    }
    public func remove(at index: Int) -> T {
        let node = self.node(at: index)
        return remove(node)
    }
    public func remove(_ node: Node) -> T {
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.prev = prev
        
        node.prev = nil
        node.next = nil
        
        return node.value
    }
    public func removeLast() -> T {
        precondition(!isEmpty)
        return remove(last!)
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
            node = nd.next
            if node != nil {
                s += ","
            }
        }
        return s + "]"
    }
}

// MARK: - Test Cases

let list = LinkedList<String>()
list.isEmpty
list.head
list.last
list.count

list.append("Hello")
list.isEmpty
list.head!.value
list.last!.value
list.count

list.append("World")
list.head!.value
list.last!.value
list.count

list.node(at: 0)
list.node(at: 1)

list[0]
list[1]

let list2 = LinkedList<String>()
list2.append("Goodbye")
list2.append("World")
list.append(list2)
list2.removeAll()
list.remove(at: 2)
list.insert("Swift", at: 1)
list[0]
list[1]
list[2]

list.node(at: 0).value = "Universe"

