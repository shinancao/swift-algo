import Foundation

/// 用数组实现一个顺序栈
struct ArrayStack<Element> {
    /// 定义泛型数据data保存数据
    private var data: [Element]
    /// 定义栈的最大长度
    private var capacity = 0
    // 定义栈里实际的元素个数
    private var count = 0
    /// 判断栈是否为空
    var isEmpty: Bool {
        return count == 0
    }
    /// 获取栈顶元素
    var peek: Element? {
        guard count > 0 else {
            return nil
        }
        return data[count - 1]
    }
    
    init(defaultElement: Element, capacity: Int) {
        data = [Element](repeating: defaultElement, count: capacity)
        self.capacity = capacity
    }
    
    /// 入栈操作
    mutating func push(_ item: Element) -> Bool {
        // 如果栈满了，则入栈失败
        guard count < capacity else {
            return false
        }
        data[count] = item
        count += 1
        return true
    }
    
    /// 出栈操作
    mutating func pop() -> Element? {
        guard count > 0 else {
           return nil
        }
        let item = data[count - 1]
        count -= 1
        return item
    }
    
    func printAll() {
        print("[ ", terminator: "")
        for i in (0 ..< count).reversed() {
            print("\(data[i]) ", terminator: "")
        }
        print("]")
    }
}

var stack = ArrayStack(defaultElement: 0, capacity: 10)
for i in 0 ..< 10 {
    stack.push(i)
}
stack.printAll()
print(stack.peek!)
stack.pop()
stack.printAll()

