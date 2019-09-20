import UIKit

/// 实现一个支持动态扩容的数组
public struct MyMutableArray<Element> {
    /// 定义泛型数据data保存数据
    private var data: [Element]
    /// 定义默认值
    private var defaultElement: Element
    /// 定义实际个数
    private var count = 0
    
    /// 构造方法
    /// - parameter defaultElement: 默认值，用来占位
    /// - parameter capacity: 数组长度
    init(defaultElement: Element, capacity: Int) {
        data = [Element](repeating: defaultElement, count: capacity)
        self.defaultElement = defaultElement
    }
    
    /// 添加元素
    mutating func add(value: Element) {
        // 如果元素的个数已经达到了数组的容量，则将数组扩容为原来的2倍
        if count == data.count {
            resize(capacity: 2 * data.count)
        }
        
        data[count] = value
        count += 1
    }
    
    /// 删除指定位置的元素
    mutating func delete(at index: Int) -> Bool {
        // index 必须在 [0, count) 之间
        guard index >= 0, index < count else {
            return false
        }
        
        // [index, count - 1) 从 index 开始，元素依次向前移动一位
        for i in index ..< count-1 {
            data[i] = data[i+1]
        }
        count -= 1
        // 将之前数组中最后一个元素置为默认值
        data[count] = self.defaultElement
        
        // 缩容
        if count == data.count/4 && data.count/2 != 0 {
            resize(capacity: data.count/2)
        }
        
        return true
    }
    
    /// 扩容方法，时间复杂度为 O(n)
    /// - parameter capacity: 新数组的大小
    private mutating func resize(capacity: Int) {
        var newData = [Element](repeating: self.defaultElement, count: capacity)
        for i in 0 ..< count {
            newData[i] = data[i]
        }
        data = newData
    }
    
    func printAll() {
        print("\(data)")
    }
}

var myMutableArray = MyMutableArray(defaultElement: 0, capacity: 10)
// 添加了3个元素
for i in 0 ..< 3 {
    myMutableArray.add(value: i)
}
myMutableArray.printAll()
// 删除1个元素，触发缩容的条件，会将容量缩减到5
myMutableArray.delete(at: 1)
myMutableArray.printAll()
// 再次添加元素，触发扩容的条件
for i in 0 ..< 15 {
    myMutableArray.add(value: i)
}
myMutableArray.printAll()

