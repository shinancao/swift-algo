import Foundation

/// 将操作封装到结点中后，这些操作基本都要用递归来操作
public class BinarySearchTree<T: Comparable> {
    public var value: T
    public var left: BinarySearchTree?
    public var right: BinarySearchTree?
    public var parent: BinarySearchTree?
    
    init(value: T) {
        self.value = value
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public func height() -> Int {
        // 叶子结点的高度为0
        if isLeaf {
            return 0
        } else {
            return 1 + Swift.max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    public func depth() -> Int {
        var node = self
        var edges = 0
        // 根结点的深度为0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    public func level() -> Int {
        return depth() + 1
    }
    
    public func insert(value: T) {
        if value < self.value {
            // 递归插入左边
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            // 递归插入右边
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    public func find(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.find(value: value)
        } else if value > self.value {
            return right?.find(value: value)
        } else {
            return self
        }
    }
    
    public func traverseInOrder(_ process: (T) -> Void) {
        left?.traverseInOrder(process)
        process(value)
        right?.traverseInOrder(process)
    }
    
    public func traversePreOrder(_ process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process)
        right?.traversePreOrder(process)
    }
    
    public func traversePostOrder(_ process: (T) -> Void) {
        left?.traversePostOrder(process)
        right?.traversePostOrder(process)
        process(value)
    }
    
    public func map(_ formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left {
            a += left.map(formula)
        }
        a.append(formula(value))
        if let right = right {
            a += right.map(formula)
        }
        return a
    }
    
    public func toArray() -> [T] {
        return map { $0 }
    }
    
    /// 二叉查找树中，最下值一定在最左边
    public func min() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    /// 同样地，二叉查找树中，最大值一定在最右边
    public func max() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    /// @discardableResult表示返回结果可以忽略
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?
        
        // 找到替代结点，稍微放于待删除结点的位置
        // 可以拿右子树中最小的结点，也可以拿左子树中最大的结点
        if let right = right {
            replacement = right.min()
        } else if let left = left {
            replacement = left.max()
        } else {
            replacement = nil
        }
        
        // 将替代结点从原来的位置移除掉
        replacement?.remove()
        
        // 将替代结点放于当前位置
        replacement?.left = left
        replacement?.right = right
        left?.parent = replacement
        right?.parent = replacement
        // 将替代结点挂在当前结点的父结点上
        reconnectParentTo(node: replacement)
        
        // 将当前结点从树中移除掉
        left = nil
        right = nil
        parent = nil
        
        return replacement
    }
    
    /// 找当前结点的前驱结点
    /// 前驱结点是所有小于当前结点中的最大结点
    public func pred() -> BinarySearchTree? {
        // 如果有左子树，前驱结点一定是左子树中最大的结点
        if let left = left {
            return left.max()
        } else {
        // 没有左子树就往上找，找到第一个父结点小于当前结点的就是它的前驱结点了
            var node = self
            while let parent = node.parent {
                if parent.value < value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
    
    /// 找当前结点的后继结点
    /// 后继结点是所有大于当前结点中的最小结点
    public func succ() -> BinarySearchTree? {
        // 如果有右子树，后继结点一定是右子树中最小的结点
        if let right = right {
            return right.min()
        } else {
        // 如果没有右子树，找到第一个父结点大于当前结点的就是它的后继结点了
            var node = self
            while let parent = node.parent {
                if parent.value > value {
                    return parent
                }
                node = parent
            }
            return nil
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

let tree = BinarySearchTree(array: [7, 2, 5, 10, 9, 1])
print(tree)
if let newTree = tree.remove() {
    print(newTree)
}

