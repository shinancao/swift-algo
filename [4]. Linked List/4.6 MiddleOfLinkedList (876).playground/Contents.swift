import Foundation
/**
 给定一个带有头结点 head 的非空单链表，返回链表的中间结点。如果有两个中间结点，则返回第二个中间结点。

 示例 1：

 输入：[1,2,3,4,5]
 输出：此列表中的结点 3 (序列化形式：[3,4,5])
 返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
 注意，我们返回了一个 ListNode 类型的对象 ans，这样：
ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
 示例 2：

 输入：[1,2,3,4,5,6]
 输出：此列表中的结点 4 (序列化形式：[4,5,6])
 由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。
 
 提示：给定链表的结点数介于 1 和 100 之间。
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
    /// 将链表中的结点映射到数组中，然后取数组的中间元素
    func middleNode(_ head: ListNode?) -> ListNode? {
        var arr = [ListNode]()
        var p = head
        while p != nil {
            arr.append(p!)
            p = p!.next
        }
        return arr[arr.count / 2]
    }
    /// 用一个慢指针和快指针，快指针的移动速度是慢指针的两倍
    func middleNode1(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        while fast != nil && fast!.next != nil  {
            slow = slow?.next
            // fast走的速度会比slow快两倍
            fast = fast!.next?.next
        }
        return slow
    }
}

let head = ListNode(1)
var tmp = head
tmp.next = ListNode(2)
tmp = tmp.next!
tmp.next = ListNode(3)
tmp = tmp.next!
tmp.next = ListNode(4)
tmp = tmp.next!
tmp.next = ListNode(5)
print(head)

let solution = Solution()
//let middleNode = solution.middleNode(head)!
let middleNode = solution.middleNode1(head)!
print(middleNode)
