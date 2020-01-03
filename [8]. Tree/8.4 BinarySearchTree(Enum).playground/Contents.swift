import Foundation

public enum BinarySearchTree<T: Comparable> {
    case empty
    case leaf(T)
    indirect case node(BinarySearchTree<T>, T, BinarySearchTree<T>)
    
    public var count: Int {
        switch self {
        case .empty:
            return 0
        case .leaf:
            return 1
        case let .node(left, _, right):
            return left.count + 1 + right.count
        }
    }
    
    public func insert(_ newValue: T) -> BinarySearchTree {
        switch self {
        case .empty:
            return .leaf(newValue)
        case let .leaf(value):
            if newValue < value {
                return .node(.leaf(newValue), value, .empty)
            } else {
                return .node(.empty, value, .leaf(newValue))
            }
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.insert(newValue), value, right)
            } else {
                return .node(left, value, right.insert(newValue))
            }
        }
    }
    
    public func search(_ x: T) -> BinarySearchTree? {
        switch self {
        case .empty:
            return nil
        case let .leaf(y):
            return (x == y) ? self : nil
        case let .node(left, y, right):
            if x < y {
                return left.search(x)
            } else {
                return right.search(x)
            }
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty:
            return ""
        case let .leaf(value):
            return "\(value)"
        case let .node(left, value, right):
            return "(\(left.description)) <- \(value) -> (\(right.description))"
        }
    }
}

// MARK: - Test Cases

var tree = BinarySearchTree.leaf(7)
tree = tree.insert(2)
tree = tree.insert(5)
tree = tree.insert(19)
tree = tree.insert(10)

print(tree)

print(tree.search(10)!)
