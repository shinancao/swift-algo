import UIKit

/// 实现一个固定长度的数组
public struct MyArray<Element> {
    /// 定义泛型数据data保存数据
    private var data: [Element]
    /// 定义数组长度
    private var capacity = 0
    /// 定义实际个数
    private var count = 0
    
    /// 构造方法
    /// - parameter defaultElement: 默认值，用来占位
    /// - parameter capacity: 数组长度
    init(defaultElement: Element, capacity: Int) {
        data = [Element](repeating: defaultElement, count: capacity)
        self.capacity = capacity
    }
    
    /// 获取指定位置的元素
    /// - parameter index: 元素位置
    func find(at index: Int) -> Element? {
        // index 必须在 [0, count) 之间
        guard index >= 0, index < count else {
            return nil
        }
        
        return data[index]
    }
    
    /// 删除指定位置的元素
    /// - parameter index: 元素位置
    mutating func delete(at index: Int) -> Bool {
        // index 必须在 [0, count) 之间
        guard index >= 0, index < count else {
            return false
        }
        
        // [index, count - 1) 从 index 开始，元素依次向前移动一位
        for i in index ..< count - 1 {
            data[i] = data[i+1]
        }
        
        // 结尾的一个元素没有从原来位置移除掉，因为这个位置的元素别人取不到
        count -= 1
        return true
    }
    
    /// 在指定位置插入元素
    /// - parameter index: 元素要插入的位置
    mutating func insert(value: Element, at index: Int) -> Bool {
        // index 必须在 [0, count) 之间，并且count不能超过数组的长度
        guard index >= 0, index < count, count < capacity else {
            return false
        }
        
        // [count - 1, index] 从 count -1 开始，元素依次向后移动一位
        for i in (index ... count - 1).reversed() {
            data[i+1] = data[i]
        }
        
        data[index] = value
        count += 1
        return true
    }
    
    /// 添加元素
    mutating func add(value: Element) -> Bool {
        // 数组已满了，则不能再追加元素
        guard count < capacity else {
            return false
        }
        
        data[count] = value
        count += 1
        return true
    }
    
    func printAll() {
        for i in 0 ..< count {
            print("\(data[i]) ", terminator: "")
        }
        print("")
    }
}

var array = MyArray(defaultElement: 0, capacity: 10)
for i in 0 ..< 5 {
    array.add(value: i)
}
array.printAll()

let e = array.find(at: 2)
print("find element: \(String(describing: e))")

array.insert(value: 9, at: 8)
array.printAll()

array.insert(value: 30, at: 3)
array.printAll()

array.delete(at: 4)
array.printAll()

