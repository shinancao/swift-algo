import Foundation

/// 对Swift中array的简单封装
public struct Stack<T> {
    fileprivate var array: [T]
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

var stackOfNames = Stack(array: ["Carl", "Lisa", "Stephanie", "Jeff", "Wade"])
stackOfNames.push("Mike")

stackOfNames.pop()
stackOfNames.pop()

stackOfNames.isEmpty
