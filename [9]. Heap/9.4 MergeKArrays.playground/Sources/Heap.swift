import Foundation

public struct Heap<T> {
    /// 用来存储堆中的结点
    var array = [T]()
    /// 结点之间比较大小的函数
    /// 传'>'则构建大顶堆，传'<'则构建小顶堆
    /// 对于自定义的对象，也可以为其他比较方式
    private var orderFn: (T, T) -> Bool
    
    /// 初始化一个空的堆
    /// - parameter sort: 根据sort决定构造的是大顶堆还是小顶堆
    public init(sort: @escaping (T, T) -> Bool) {
        self.orderFn = sort
    }
    
    /// 用给定的数组初始化一个堆
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderFn = sort
        configureHeap(from: array)
    }
    
    /// 用给定的数组从上向下堆化
    /// 时间复杂度：O(n)
    private mutating func configureHeap(from array: [T]) {
        self.array = array
        // 从n/2到n-1为叶子结点
        // 叶子结点不需要向下堆化了，所以向下堆化从n/2-1开始，逐渐向上直到0
        for i in stride(from: (self.array.count/2-1), through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    /// 获取堆中的最大值或最小值
    public var peek: T? {
        return array.first
    }
    
    /// 向堆中插入一个元素，并保持堆的特性
    public mutating func insert(_ value: T) {
        // 将元素先放到数组的最后
        array.append(value)
        // 从下向上进行堆化，找到该元素合适的位置
        shiftUp(array.count - 1)
    }
    
    /// 向堆中插入一个序列片段，该序列中的元素类型要与堆中的一致
    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }
    
    /// 用给定的元素替换堆中指定位置的元素
    public mutating func replace(index i: Int, value: T) {
        guard i < array.count else { return }
        
        remove(at: i)
        insert(value)
    }
    
    /// 删除堆顶元素，并保持堆的特性
    @discardableResult public mutating func removeRoot() -> T? {
        guard !array.isEmpty else { return nil }
        
        if array.count == 1 {
            return array.removeLast()
        } else {
            // 将堆中最后一个元素放到堆顶位置
            // 再从上向下进行堆化，找到被放到堆顶的这个元素合适的位置
            let value = array[0]
            array[0] = array.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    /// 删除堆中指定位置的元素
    @discardableResult public mutating func remove(at index: Int) -> T? {
        guard index < array.count else { return nil }
        
        let size = array.count - 1
        if index != size {
            // 交换堆中最后一个元素和index位置的元素
            array.swapAt(index, size)
            // 从index开始向下找到
            shiftDown(from: index, until: size)
            shiftUp(index)
        }
        return array.removeLast()
    }
    
    internal func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    internal func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    internal func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    /// 从指定位置开始，比较其与父结点的值，进行交换z，直到堆顶
    /// 时间复杂度：O(logn)
    internal mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = array[childIndex]
        var parentIndex = self.parentIndex(ofIndex: index)
        
        while childIndex > 0 && orderFn(child, array[parentIndex]) {
            // 这里没有直接赋值，而只移动了childIndex的位置，等while结束后，一次赋值
            array[childIndex] = array[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        array[childIndex] = child
    }
    
    /// 递归方法
    /// 从index开始，与其左右结点比较，然后交换，直到endIndex
    /// 时间复杂度：O(logn)
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && orderFn(array[leftChildIndex], array[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderFn(array[rightChildIndex], array[first]) {
            first = rightChildIndex
        }
        if first == index {
            return
        }
        
        array.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    /// 从index开始向下堆化，直到最后一个元素
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: array.count)
    }
}

extension Heap: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}
