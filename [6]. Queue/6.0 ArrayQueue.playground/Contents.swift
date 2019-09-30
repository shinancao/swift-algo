import Foundation

struct ArrayQueue<Element> {
    /// 定义泛型数据data保存数据
    private var data: [Element]
    /// 定义栈的最大长度
    private var capacity = 0
    /// 表示队头下标
    private var head = 0
    /// 表示队尾下标
    private var tail = 0
    
    init(defaultElement: Element, capacity: Int) {
        data = [Element](repeating: defaultElement, count: capacity)
        self.capacity = capacity
    }
    
    /// 判断队列是否为空
    var isEmpty: Bool {
        return head == tail
    }
    
    /// 获取队列的大小
    var size: Int {
        return tail - head
    }
    
    /// 获取队列顶部的元素
    var peek: Element? {
        return isEmpty ? nil : data[head]
    }
    
    /// 入队列，从队尾添加，实现一个有界队列
//    mutating func enqueue(_ item: Element) -> Bool {
//        // 如果tail = capacity表示队列已满
//        guard tail < capacity else {
//            return false
//        }
//        data[tail] = item
//        tail += 1
//        return true
//    }
    
    /// 入队列，从队尾添加，实现一个无界队列，但是当队列满了之后也无法添加了
    mutating func enqueue(_ item: Element) -> Bool {
        // 队尾已经没有空间可放
        if tail == capacity {
            // 队头也没有空间可放，表示队列都被占满了
            if head == 0 {
                return false
            }
            // 搬移数据
            for i in head ..< tail {
                data[i - head] = data[i]
            }
            tail -= head
            head = 0
        }
        
        data[tail] = item
        tail += 1
        return true
    }
    
    /// 出队列，从队头出
    mutating func dequeue() -> Element? {
        guard !isEmpty else {
            return nil
        }
        let item = data[head]
        head += 1
        return item
    }
    
    func printAll() {
        print("[ ", terminator: "")
        for i in (head ..< tail).reversed() {
            print("\(data[i]) ", terminator: "")
        }
        print("]")
    }
}

var queue = ArrayQueue(defaultElement: 0, capacity: 10)
for i in 0 ..< 10 {
    queue.enqueue(i)
}
queue.printAll()
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.printAll()
queue.enqueue(11)
queue.printAll()
