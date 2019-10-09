import Foundation

class CircleQueue<Element> {
    private var data: [Element]
    private var capacity: Int
    private var defaultElement: Element
    private var head = 0
    private var tail = 0
    
    init(defaultElement: Element, capacity: Int) {
        data = [Element](repeating: defaultElement, count: capacity)
        self.defaultElement = defaultElement
        self.capacity = capacity
    }
    
    func enqueue(_ item: Element) -> Bool {
        // 注意队列满了的判断条件
        // 这种情况下tail始终指向最后一个元素的下一个位置，所以tail指向的位置会一直空着
        if (tail + 1) % capacity == head {
            return false
        }
      
        data[tail] = item
        // 注意tail指针的更新
        tail = (tail + 1) % capacity
        return true
    }
    
    func dequeue() -> Element? {
        // 队列为空
        if tail == head {
            return nil
        }
    
        let item = data[head]
        data[head] = self.defaultElement
        // 注意head指针的更新
        head = (head + 1) % capacity
        return item
    }
    
    func printAll() {
        print("[ ", terminator: "")
        for i in (0 ..< capacity) {
            print("\(data[i]) ", terminator: "")
        }
        print("]")
    }
}

var queue = CircleQueue(defaultElement: 0, capacity: 10)
for i in 1 ... 10 {
    queue.enqueue(i)
}
queue.printAll()
queue.dequeue()
queue.dequeue()
queue.printAll()
queue.enqueue(11)
queue.enqueue(12)
queue.printAll()
