import Foundation

public final class LinkedList<T> {
    /// 定义链表中的结点结构
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    /// 为结点起一个别名，以提高代码的可读性
    public typealias Node = LinkedListNode<T>
    
    /// 链表的头结点，存储有效的结点值
    private(set) var head: Node?
    
    /// 遍历链表，拿到最后一个结点
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    /// 判断链表是否为空
    public var isEmpty: Bool {
        return head == nil
    }
    
    /// 遍历链表，以统计结点的个数
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
        precondition(head != nil, "List is empty")
        precondition(index >= 0, "index must be greater than 0")
        
        var node = head
        var num = 0
        while let nd = node {
            if num == index {
                break
            }
            num += 1
            node = nd.next
        }
        
        precondition(node != nil, "index is out of bounds.")
        
        return node!
    }
    
    public func append(_ value: T) {
        let newNode = Node(value: value)
        append(newNode)
    }
    
    public func append(_ node: Node) {
        let newNode = node
        if let lastNode = last {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func append(_ list: LinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            append(node.value)
            nodeToCopy = node.next
        }
    }
    
    public func insert(_ value: T, at index: Int) {
        let newNode = Node(value: value)
        insert(newNode, at: index)
    }
    
    public func insert(_ newNode: Node, at index: Int) {
        let prev = node(at: index - 1)
        let next = prev.next
        prev.next = newNode
        newNode.next = next
    }
    
    public func removeAll() {
        head = nil
    }
    
    @discardableResult public func remove(node: Node) -> T {
        if head === node {
            head = node.next
        } else {
            var prev = head
            var pNode = head?.next
            while let nd = pNode {
                if nd === node {
                    prev?.next = nd.next
                    break
                }
                prev = nd
                pNode = nd.next
            }
        }
        
        node.next = nil
        return node.value
    }
    
    @discardableResult public func removeLast() -> T {
        precondition(!isEmpty)
        return remove(node: last!)
    }
    
    @discardableResult public func remove(at index: Int) -> T {
        let node = self.node(at: index)
        return remove(node: node)
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
                s += ", "
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

print(list)
list.remove(at: 0)
print(list)

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


