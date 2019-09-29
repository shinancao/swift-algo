import Foundation

/// 实现一个非循环的双向链表，支持插入、删除、查找操作
class Node<T> : CustomStringConvertible {
    var value: T?
    var prev: Node?
    var next: Node?
    var description: String {
        return String(describing: value)
    }
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}

class DoubleList<Element: Equatable> : CustomStringConvertible {
    var head: Node<Element>
    var description: String {
        var node = head.next
        var str = String(describing: head.value)
        while node != nil {
            str += "<——>"
            str += String(describing: node!.value)
            node = node!.next
        }
        str += "<——>"
        str += String(describing: node?.value)
        return str
    }
    
    init(value: Element) {
        let node = Node(value: value)
        self.head = node
    }
    
    func node(with value: Element) -> Node<Element>? {
        var tmpNode: Node<Element>? = head
        while tmpNode != nil {
            if tmpNode!.value == value {
                return tmpNode
            }
            tmpNode = tmpNode!.next
        }
        return nil
    }
    
    func node(at index: Int) -> Node<Element>? {
        var num = 0
        var tmpNode: Node<Element>? = head
        while tmpNode != nil {
            if num == index  {
                return tmpNode
            }
            tmpNode = tmpNode!.next
            num += 1
        }
        return nil
    }
    
    func insert(after node: Node<Element>, newNode: Node<Element>) -> Node<Element> {
        newNode.next = node.next
        node.next?.prev = newNode
        node.next = newNode
        newNode.prev = node
        return newNode
    }
    
    func insert(after node: Node<Element>, newValue: Element) -> Node<Element> {
        let newNode = Node(value: newValue)
        insert(after: node, newNode: newNode)
        return newNode
    }
    
    func insert(before node: Node<Element>, newNode: Node<Element>) -> Node<Element>? {
        var tmpNode: Node<Element>? = head
        while tmpNode != nil {
            if tmpNode === node {
                // 找到了指定的node，然后在其前面插入新结点
                newNode.prev = node.prev
                node.prev?.next = newNode
                newNode.next = node
                node.prev = newNode
                return newNode
            }
            tmpNode = tmpNode!.next
        }
        return nil
    }
    
    func insert(before node: Node<Element>, newValue: Element) -> Node<Element>? {
        let newNode = Node(value: newValue)
        return insert(before: node, newNode: newNode)
    }
    
    func delete(node: Node<Element>) -> Bool {
        var tmpNode: Node<Element>? = head
        while tmpNode != nil {
            if tmpNode === node {
                //找到了要删除的结点
                node.prev?.next = node.next
                node.next?.prev = node.prev
                return true
            }
            tmpNode = tmpNode!.next
        }
        return true
    }
    
    func delete(value: Element) -> Bool {
        var tmpNode: Node<Element>? = head
        while tmpNode != nil {
            if tmpNode!.value == value {
                tmpNode!.prev?.next = tmpNode!.next
                tmpNode!.next?.prev = tmpNode!.prev
                return true
            }
            tmpNode = tmpNode!.next
        }
        return true
    }
}

let list = DoubleList(value: 1)
var node = list.head
for i in 2 ... 5 {
    node = list.insert(after: node, newValue: i)
}
print(list)
print(node.prev!)
list.delete(node: node)
print(list)
print(node)
node = list.node(at: 2)!
list.insert(before: node, newValue: 6)
print(list)
