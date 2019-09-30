import Foundation

class Node<T> {
    var value: T?
    var next: Node<T>?
    
    init(){}
    
    init(value: T) {
        self.value = value
    }
}

/// 用链表实现一个链式队列
class ListQueue<Element> {
    /// 指向队首
    private var head: Node<Element>?
    /// 指向队尾
    private var tail: Node<Element>?
    /// 判断队列是否为空
    var isEmpty: Bool {
        return head == nil
    }
    /// 获取队列顶部的元素
    var peek: Element? {
        return head?.value
    }
    /// 入队列
    func enqueue(_ item: Element) {
        let node = Node(value: item)
        if tail == nil {
            tail = node
            head = node
        } else {
            tail!.next = node
            tail = tail!.next
        }
    }
    
    /// 出队列
    func dequeue() -> Element? {
        guard head != nil else {
            return nil
        }
        let value = head!.value
        head = head!.next
        if head == nil {
            // 队列已经为空，tail也要置空
            tail = nil
        }
        return value
    }
    
    func printAll() {
        print("[ ", terminator: "")
        var tmpNode = head
        while tmpNode != nil {
            print("\(tmpNode!.value!) ", terminator: "")
            tmpNode = tmpNode!.next
        }
        print("]")
    }
}

let queue = ListQueue<Int>()
for i in 0 ..< 10 {
    queue.enqueue(i)
}
queue.printAll()
queue.dequeue()
queue.dequeue()
queue.printAll()
