import Foundation

class Node<T> {
    var value: T?
    var next: Node<T>?
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}
/// 用链表实现一个链式栈
class ListStack<Element> {
    /// 哨兵结点
    private var dummy = Node<Element>()
    /// 判断栈是否为空
    var isEmpty: Bool {
        return dummy.next == nil
    }
    /// 获取栈顶元素
    var peek: Element? {
        return dummy.next?.value
    }
    
    /// 入栈
    func push(_ item: Element) {
        let node = Node(value: item)
        node.next = dummy.next
        dummy.next = node
    }
    
    /// 出栈
    func pop() -> Element? {
        let node = dummy.next
        dummy.next = node?.next
        node?.next = nil
        return node?.value
    }
    
    func printAll() {
        var tmpNode = dummy.next
        print("[ ", terminator: "")
        while tmpNode != nil {
            print("\(String(describing: tmpNode!.value!)) ", terminator: "")
            tmpNode = tmpNode!.next
        }
        print("]")
    }
}

let stack = ListStack<Int>()
for i in 0 ..< 10 {
    stack.push(i)
}
stack.printAll()
stack.pop()
stack.printAll()
print(stack.peek!)

