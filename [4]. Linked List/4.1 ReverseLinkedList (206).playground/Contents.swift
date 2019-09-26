import Foundation
/**
 206. 反转一个单链表。
 
 示例:
 
 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
 */
class Node<T> : CustomStringConvertible {
    var value: T?
    var next: Node?
    var description: String {
        var node = next
        var str = String(describing: value)
        while node != nil {
            str += "——>"
            str += String(describing: node?.value)
            node = node?.next
        }
        str += "——>"
        str += "NULL"
        return str
    }
    
    init() {}
    
    init(value: T) {
        self.value = value
    }
}

class Solution {
    /// 利用哨兵结点解决
    func reverseList1(_ head: Node<Int>?) -> Node<Int>? {
        guard let head = head else { return nil }
        // 创建哨兵结点
        let dummy = Node<Int>()
        // 将哨兵结点挂到给定的列表最前面
        dummy.next = head
        // curr为当前操作的结点
        var curr = head.next
        // 从给定的列表中的第二个节点开始切断，此后从切断的列表中每次从头取一个，利用头插法依次插入到哨兵结点的后面
        head.next = nil
        // 记录下一次要取的结点
        var next: Node<Int>? = nil
        // 如果当前待插入的结点为nil，说明所有的结点都已经操作完毕
        while curr != nil {
            next = curr!.next
            curr!.next = dummy.next
            dummy.next = curr
            curr = next
        }
        // 返回反转的链表
        return dummy.next
    }
    
    /// 不利用哨兵结点结点
    func reverseList2(_ head: Node<Int>?) -> Node<Int>? {
        // 给定的结点将依次挂在prev的前面，然后将prev指向curr结点，curr再重新去取一个，重复操作，直到curr为空
        var prev: Node<Int>? = nil
        var curr = head
        while curr != nil {
            let nextTemp = curr!.next
            curr!.next = prev
            prev = curr
            curr = nextTemp
        }
        return prev
    }
    
    /// 递归解法
    func reverseList3(_ head: Node<Int>?) -> Node<Int>? {
        // head就是第nk个结点
        // nk为最后一个结点时，不需要反转了，所以直接返回改结点
        if head == nil || head?.next == nil {
            return head
        }
        // 得到从nk+1开始向后的已反转的部分
        let p = reverseList3(head!.next)
        // 公式：nk.next.next = nk
        head!.next!.next = head
        // 经过上面的操作后，nk.next指向nk+1，nk+1.next又指向nk，会形成一个小环，所以需要将nk.next置为空
        head!.next = nil
        return p
    }
}

let head = Node(value: 1)
var last = head
for i in 2 ... 5 {
    let node = Node(value: i)
    last.next = node
    last = node
}
print(head)
let solution = Solution()
let head1 = solution.reverseList1(head) ?? Node<Int>()
print(head1)
let head2 = solution.reverseList2(head1) ?? Node<Int>()
print(head2)
let head3 = solution.reverseList3(head2) ?? Node<Int>()
print(head3)


