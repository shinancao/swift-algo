import Foundation

/// 用enum实现二叉树，因为enum是值类型，所以每次插入或删除时，都会给你一个全新的一个树的拷贝
public indirect enum BinaryTree<T> {
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty
    
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    public func traverseInOrder(_ process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process)
            process(value)
            right.traverseInOrder(process)
        }
    }
    
    public func traversePreOrder(_ process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            process(value)
            left.traversePreOrder(process)
            right.traversePreOrder(process)
        }
    }
    
    public func traversePostOrder(_ process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traversePreOrder(process)
            right.traversePreOrder(process)
            process(value)
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [\(left.description)], right = [(\(right.description))]"
        case .empty:
            return ""
        }
    }
}

// MARK: - Test Cases

// 比如我们要构造这样一个树，这是一个表达式(5 * (a - 10)) + (-4 * (3 / b))
/**
       +
   /       \
  *         *
 / \       / \
 5  -     -   /
   / \   /   / \
   a 10  4   3  b
 **/

// 构造叶子结点
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// 构造左边中间的结点
let minus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", minus10)

// 构造右边中间的结点
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// 根结点
let tree = BinaryTree.node(timesLeft, "+", timesRight)

print(tree)

print(tree.count)

tree.traverseInOrder {
    print($0)
}
