import Foundation
/// 遍历的方式：前序（根左右）、中序（左根右）、后序（左右根）、层
enum OrderType {
    case pre, mid, post, level
}
/// 树中的结点
class Node<T: Comparable> : CustomStringConvertible {
    var value: T?
    var left: Node?
    var right: Node?
    var description: String {
        return String(describing: value)
    }
    
    init () {}
    
    init(value: T) {
        self.value = value
    }
}
/// 实现二叉查找树
/// 二叉查找树的特点：任意结点的左子树的值比其右子树的值要小
/// 二叉查找树的插入、删除、查找的时间复杂度与树的高度成正比
/// 对于平衡二叉查找树来说，插入、删除、查找的时间复杂度可以稳定在O(logn)
class BinarySearchTree {
    private var tree: Node<Int>?
    /// 待插入的结点将其挂在最下面，
    /// 遍历树，给定的值大就递归找右子树，如果右子树为空就将其挂上去，给定的值小就递归找左子树，如果左子树为空就将其挂上去
    /// 这里没有考虑有值相等的情况
    public func insert(_ value: Int) {
        if let aTree = tree {
            var p: Node<Int>? = aTree
            while p != nil {
                if (value > p!.value!) {
                    if p!.right == nil {
                        p!.right = Node(value: value)
                        return
                    }
                    p = p!.right
                } else {
                    if p!.left == nil {
                        p!.left = Node(value: value)
                        return
                    }
                    p = p!.left
                }
            }
        } else {
            tree = Node(value: value)
        }
    }
    /// 从根结点开始找，如果给定的值大就递归找右子树，如果给定的值小就递归找左子树
    public func find(_ value: Int) -> Node<Int>? {
        var p = tree
        while p != nil {
            if value > p!.value! {
                p = p!.right
            } else if value < p!.value! {
                p = p!.left
            } else {
                return p
            }
        }
        return nil
    }
    /// 删除可以分为几种情况处理
    /// 1、叶子结点 2、只有一个子结点 3、有左右两个结点
    public func delete(_ value: Int) {
        // 记录待删除结点
        var p = tree
        // 记录待删除结点的父结点
        var pp: Node<Int>?
        // 先找到要删除的结点，不能直接用find方法，我们还要记录其父结点
        while p != nil && p!.value != value {
            pp = p
            if value > p!.value! {
                p = p!.right
            } else {
                p = p!.left
            }
        }
        // 没有找到符合的结点
        if (p == nil) {
            return
        }
        // 先判断有两个结点的情况，找到与待删除结点相置换的结点后，就把问题转换成解决1、2情况了
        if p!.left != nil && p!.right != nil {
            // 在待删除结点的右子树中找到最小的值
            var minP = p!.right
            var minPP = p
            // 最小的值一定出现在左子树中，所以循环遍历左子树
            while minP!.left != nil {
                minPP = minP
                minP = minP!.left
            }
            // 此处赋值非常重要！将找到的最小值放到待删除结点的位置
            p!.value = minP!.value
            // 然后问题就转换成了删除刚找到的结点minP，而且minP的左子树一定为空
            p = minP
            pp = minPP
        }
        // 拿到待删除结点p的孩子结点，再将其挂在p的父结点上，这样就将p删除掉了
        var child: Node<Int>?
        if p!.left != nil {
            child = p!.left
        } else if p!.right != nil {
            child = p!.right
        } else {
            child = nil
        }
        // 将孩子结点挂到合适的位置
        if pp == nil {
            // 要删除的结点是根结点
            tree = child
        } else if pp!.left != nil && pp!.left!.value == p!.value {
            // 将child挂在父结点的左边
            pp!.left = child
        } else {
            pp!.right = child
        }
    }
    
    public func printAll(withType type: OrderType) {
        guard let aTree = tree else {
            return
        }
        switch type {
        case .pre:
            preOrder(aTree)
        case .mid:
            inOrder(aTree)
        case .post:
            postOrder(aTree)
        case .level:
            levelOrder(aTree)
        }
    }
    
    private func preOrder(_ node: Node<Int>) {
        print(node)
        if let left = node.left {
            preOrder(left)
        }
        if let right = node.right {
            preOrder(right)
        }
    }
    
    private func inOrder(_ node: Node<Int>) {
        if let left = node.left {
            preOrder(left)
        }
        print(node)
        if let right = node.right {
            preOrder(right)
        }
    }
    
    private func postOrder(_ node: Node<Int>) {
        if let left = node.left {
            preOrder(left)
        }
        if let right = node.right {
            preOrder(right)
        }
        print(node)
    }
    
    private func levelOrder(_ node: Node<Int>) {
        // 用一个数组模拟队列，将新元素插在0位置，从最后面取
        var queue = [Node<Int>]()
        // 指向当前正在访问的结点，从数组前面开始遍历
        var p = 0
        // 先将根结点放入队列
        queue.append(node)
        // 遍历queue，每次pop出一个元素打印，再把它的左右子结点放入队列
        while p < queue.count {
            let tmp = queue[p]
            print(tmp)
            if let left = tmp.left {
                queue.insert(left, at: 0)
            }
            if let right = tmp.right {
                queue.insert(right, at: 0)
            }
            p += 1
        }
    }
}

let arr = [33, 17, 50, 13, 18, 34, 58, 16, 25, 51, 66, 19, 27]
let bTree = BinarySearchTree()
arr.forEach { (i) in
    bTree.insert(i)
}
//print("preOrder:")
//bTree.printAll(withType: .pre)
//print("midOrder:")
//bTree.printAll(withType: .mid)
//print("postOrder:")
//bTree.printAll(withType: .post)
print("levelOrder:")
bTree.printAll(withType: .level)
//bTree.delete(16)
//bTree.delete(25)
//bTree.delete(18)
//bTree.printAll(withType: .pre)
//print(bTree.find(100) as Any)
