import Foundation

/// 实现一个固定大小的循环队列
public struct RingBuffer<T> {
    fileprivate var array: [T?]
    fileprivate var readIndex = 0
    fileprivate var writeIndex = 0
    
    public init(count: Int) {
        // 像这种数组中存储的是模板类型，又需要将数组初始一个固定大小，可以将数组中的元素定义为可选的，然后用nil占位
        array = [T?](repeating: nil, count: count)
    }
    
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex%array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex%array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    fileprivate var avaliableSpaceForReading: Int {
        return writeIndex - readIndex
    }
    
    fileprivate var avaliableSpaceForWriting: Int {
        return array.count - avaliableSpaceForReading
    }
    
    public var isEmpty: Bool {
        return avaliableSpaceForReading == 0
    }
    
    public var isFull: Bool {
        return avaliableSpaceForWriting == 0
    }
}

// MARK: - Test Cases

var buffer = RingBuffer<Int>(count: 3)
buffer.write(0)
buffer.write(1)
buffer.write(2)

buffer.read()
buffer.read()

buffer.write(3)
buffer.write(4)

