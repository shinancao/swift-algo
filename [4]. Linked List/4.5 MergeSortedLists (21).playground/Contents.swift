import Foundation
/**
 将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
 
 示例：
 
 输入：1->2->4, 1->3->4
 输出：1->1->2->3->4->4
 */
public class ListNode : CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public var description: String {
        var node = next
        var str = String(describing: val)
        while node != nil {
            str += "——>"
            str += String(describing: node?.val ?? 0)
            node = node?.next
        }
        str += "——>"
        str += "NULL"
        return str
    }
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    /// 迭代解法
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 创建哨兵结点
        let dummy = ListNode(-1)
        // prev指针始终追踪合并后的链表的最后一个结点
        var prev = dummy
        // p1,p2分别追踪两个链表当前最前面的结点
        var p1 = l1
        var p2 = l2
        // 遍历两个链表，比较当前两个链表最前的结点值，小的结点就挂到prev后面，然后prev和小的一方的链表指针都移到下一个结点
        while p1 != nil && p2 != nil {
            if p1!.val <= p2!.val {
                prev.next = p1
                p1 = p1!.next
            } else {
                prev.next = p2
                p2 = p2!.next
            }
            prev = prev.next!
        }
        // 最后把没有合并到新链中的剩余部分，都挂到prev后面
        prev.next = p1 ?? p2
        return dummy.next
    }
    
    /// 递归解法
    /// 这种解法可以看成从后向前构建新的链表
    func mergeTwoLists2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 有一条链为空，说明另一条链已经排好了
        if l1 === nil {
            return l2
        } else if l2 === nil {
            return l1
        } else if l1!.val < l2!.val {
            // 将l1挂在后面已经排好的链上，这里要注意传参，传的是l1!.next，相当于将l1的指针后移
            l1!.next = mergeTwoLists2(l1!.next, l2)
            return l1
        } else {
            l2!.next = mergeTwoLists2(l1, l2!.next)
            return l2
        }
    }
}

let l1 = ListNode(1)
var tmp = l1
tmp.next = ListNode(4)
tmp = tmp.next!
tmp.next = ListNode(5)
tmp = tmp.next!
print(l1)

let l2 = ListNode(1)
tmp = l2
tmp.next = ListNode(2)
tmp = tmp.next!
tmp.next = ListNode(3)
tmp = tmp.next!
tmp.next = ListNode(6)
print(l2)

let solution = Solution()
//let mergedList = solution.mergeTwoLists(l1, l2)!
//print(mergedList)
let mergedList = solution.mergeTwoLists2(l1, l2)!
print(mergedList)

