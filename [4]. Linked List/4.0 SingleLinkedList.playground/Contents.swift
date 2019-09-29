import Foundation

/// 实现一个单链表，支持插入、删除、查找操作
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

class List<Element: Equatable> : CustomStringConvertible {
    /// 哨兵结点，不存储数据，在插入了节点后，其next就不为空了
    private var dummy = Node<Element>()
    /// 计算结点的个数
    var size: Int {
        var num = 0
        var tmpNode = dummy.next
        while tmpNode != nil {
            num += 1
            tmpNode = tmpNode!.next
        }
        return num
    }
    /// 是否为空链表
    var isEmpty: Bool {
        return size > 0
    }
    /// 输出链表
    var description: String {
        var node = dummy.next
        var str = "dummy"
        while node != nil {
            str += "——>"
            str += String(describing: node!.value)
            node = node!.next
        }
        return str
    }
    
    /// 查找值为value的结点
    func node(with value: Element) -> Node<Element>? {
        var node = dummy.next
        while node != nil {
            if node!.value == value {
                return node
            }
            node = node!.next
        }
        return nil
    }
    
    /// 查找index处的结点
    func node(at index: Int) -> Node<Element>? {
        var num = 0
        var node = dummy.next
        while node != nil {
            if num == index {
                return node
            }
            node = node!.next
            num += 1
        }
        return nil
    }
    
    /// 将value值插入到第一个结点
    /// - returns: Node<Element> 返回新插入的结点
    func insertToHead(value: Element) -> Node<Element> {
        let newNode = Node(value: value)
        insertToHead(node: newNode)
        return newNode
    }
    
    /// 将node插入到第一个结点
    func insertToHead(node: Node<Element>) -> Node<Element> {
        node.next = dummy.next
        dummy.next = node
        return node
    }
    
    /// 在给定值后插入
    func insert(after node: Node<Element>, newValue: Element) -> Node<Element> {
        let newNode = Node(value: newValue)
        insert(after: node, newNode: newNode)
        return newNode
    }
    
    /// 在给定结点后插入
    func insert(after node: Node<Element>, newNode: Node<Element>) -> Node<Element>{
        newNode.next = node.next
        node.next = newNode
        return newNode
    }
    
    /// 在给定值前插入
    func insert(before node: Node<Element>, newValue: Element) -> Node<Element> {
        let newNode = Node(value: newValue)
        insert(before: node, newNode: newNode)
        return newNode
    }
    
    /// 在给定结点前插入
    func insert(before node: Node<Element>, newNode: Node<Element>) -> Node<Element> {
        var lastNode = dummy
        var tmpNode = dummy.next
        while tmpNode != nil {
            if tmpNode === node {
                newNode.next = tmpNode
                lastNode.next = newNode
                break
            }
            lastNode = tmpNode!
            tmpNode = tmpNode!.next
        }
        return newNode
    }
    
    /// 删除指定的结点
    func delete(node: Node<Element>) -> Bool {
        var lastNode = dummy
        var tmpNode = dummy.next
        while tmpNode != nil {
            if tmpNode === node {
                lastNode.next = tmpNode!.next
                return true
            }
            lastNode = tmpNode!
            tmpNode = tmpNode!.next
        }
        return false
    }
    
    /// 删除指定的值
    func delete(value: Element) -> Bool{
        var lastNode = dummy
        var tmpNode = dummy.next
        while tmpNode != nil {
            if tmpNode!.value! == value {
                lastNode.next = tmpNode!.next
                return true
            }
            lastNode = tmpNode!
            tmpNode = tmpNode!.next
        }
        return false
    }
}

let list = List<Int>()
var node = list.insertToHead(value: 1)
for i in 2 ... 5 {
    node = list.insert(after: node, newValue: i)
}
print(list)
list.delete(node: node)
print(list)
node = list.node(at: 2)!
print(node)






