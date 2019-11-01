import Foundation
/**
 给定一个二叉树，找出其最大深度。

 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

 说明: 叶子节点是指没有子节点的节点。

 示例：
 给定二叉树 [3,9,20,null,null,15,7]，

     3
    / \
   9  20
   /   \
  15    7
 返回它的最大深度 3 。
 */
class TreeNode: CustomStringConvertible {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    var description: String {
        return String(describing: val)
    }
    
    init(val: Int) {
        self.val = val
    }
}

class Solution {
    // 方式一：递归法
    public func maxDepth(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        
        return max(maxDepth(node.left), maxDepth(node.right)) + 1
    }
    
    // 方式二：按层遍历
    func maxDepth2(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        // 模拟队列，定义指针p，从数组前面开始访问元素
        var queue = [TreeNode]()
        // 指向当前正在访问的结点
        var p = 0
        // 将根结点放入队列
        queue.append(node)
        // 记录当前正在遍历的层的结点个数
        var curCount = 1
        // 记录下一层叶子结点的个数
        var nextCount = 0
        // 记录深度，每一层结束后加1
        var depth = 0
        while p < queue.count {
            curCount -= 1
            let tmpNode = queue[p]
            if let left = tmpNode.left {
                queue.append(left)
                nextCount += 1
            }
            if let right = tmpNode.right {
                queue.append(right)
                nextCount += 1
            }
            // 每遍历一个结点将curCount减1，为0时，说明这一层的结点都已经遍历完了
            if (curCount == 0) {
                curCount = nextCount
                nextCount = 0
                depth += 1
            }
            p += 1
        }
        return depth
    }
}
