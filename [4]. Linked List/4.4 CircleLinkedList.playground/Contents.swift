import Foundation

/// 实现一个循环链表，支持插入、删除、查找操作
class Node<T> : CustomStringConvertible {
    var value: T?
    var next: Node?
    var description: String {
        return String(describing: value)
    }
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}

class CircleList<Element: Equatable> : CustomStringConvertible {
    // 哨兵结点，非空循环链表中尾结点的next指针一直指向哨兵结点，空循环链表中尾结点指向哨兵结点
    private var dummy = Node<Element>()
    var tail: Node<Element>
    var size: Int {
        var num = 0
        var node = dummy.next
        while node != nil && node !== dummy {
            num += 1
            node = node!.next
        }
        return num
    }
    var isEmpty: Bool {
        return tail === dummy
    }
    var description: String {
        var node = dummy.next
        var str = "dummy"
        while node != nil && node !== dummy {
            str += "——>"
            str += String(describing: node!.value)
            node = node!.next
        }
        str += "——>"
        str += "dummy"
        return str
    }
    
    init() {
        tail = dummy
    }
    
    func node(with value: Element) -> Node<Element>? {
        var node = dummy.next
        while node !== dummy {
            if node!.value == value {
                return node
            }
            node = node!.next
        }
        return nil
    }
    
    func node(at index: Int) -> Node<Element>? {
        var num = 0
        var node = dummy.next
        while node !== dummy {
            if (num == index) {
                return node
            }
            node = node!.next
            num += 1
        }
        return nil
    }
    
    func insertToHead(value: Element) -> Node<Element> {
        let newNode = Node(value: value)
        insertToHead(node: newNode)
        return newNode
    }
    
    func insertToHead(node: Node<Element>) -> Node<Element> {
        node.next = dummy.next
        dummy.next = node
        // 如果当前还是空链表，新插入的结点就成了最新的尾结点
        if tail === dummy {
            tail = node
            tail.next = dummy
        }
        return node
    }
    
    func insert(after node: Node<Element>, newValue: Element) -> Node<Element> {
        let newNode = Node(value: newValue)
        insert(after: node, newNode: newNode)
        return newNode
    }
    
    func insert(after node: Node<Element>, newNode: Node<Element>) -> Node<Element> {
        newNode.next = node.next
        node.next = newNode
        if (node === tail) {
            tail = newNode
        }
        return newNode
    }
    
    func insert(before node: Node<Element>, newValue: Element) -> Node<Element> {
        let newNode = Node(value: newValue)
        insert(before: node, newNode: newNode)
        return newNode
    }
    
    func insert(before node: Node<Element>, newNode: Node<Element>) -> Node<Element> {
        var prevNode = dummy
        var tmpNode = dummy.next
        while tmpNode !== dummy {
            if tmpNode === node {
                newNode.next = tmpNode
                prevNode.next = newNode
            }
            prevNode = tmpNode!
            tmpNode = tmpNode!.next
        }
        return newNode
    }
    
    func delete(node: Node<Element>) -> Bool {
        var prevNode = dummy
        var tmpNode = dummy.next
        while tmpNode !== dummy {
            if tmpNode === node {
                prevNode.next = tmpNode!.next
                if tmpNode === tail {
                    tail = tmpNode!
                }
                return true
            }
            prevNode = tmpNode!
            tmpNode = tmpNode!.next
        }
        return false
    }
    
    func delete(value: Element) -> Bool {
        var prevNode = dummy
        var tmpNode = dummy.next
        while tmpNode !== dummy {
            if tmpNode!.value == value {
                prevNode.next = tmpNode?.next
                if tmpNode === tail {
                    tail = tmpNode!
                }
                return true
            }
            prevNode = tmpNode!
            tmpNode = tmpNode!.next
        }
        return false
    }
}

let list = CircleList<Int> ()
var node = list.insertToHead(value: 1)
for i in 2 ... 5 {
    node = list.insert(after: node, newValue: i)
}
print(list)
node = list.insert(before: node, newValue: 6)
print(list)
print(list.tail.next)
list.delete(node: node)
print(list)
