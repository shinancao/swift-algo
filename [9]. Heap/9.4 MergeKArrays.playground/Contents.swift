import UIKit

/// 利用优先级队列合并K个有序数组
/// 时间复杂度：O(nlogn)
public func mergeKArrays<T>(_ a: [[T]], _ sort: @escaping (T, T) -> Bool) -> [T] {
    var res = [T]()
    var queue = PriorityQueue<(val: T, idx: Int, subIdx: Int)> { sort($0.val, $1.val) }
    // 先从每个数组中取出第一个元素放入队列中
    for i in stride(from: 0, to: a.count, by: 1) {
        let item = (val: a[i][0], idx: i, subIdx: 0)
        queue.enqueue(value: item)
    }
    print(queue)
    while !queue.isEmpty {
        // 此时顶部元素一定是未放入res中最小的元素，直接将其放入res后面
        let top = queue.dequeue()!
        res.append(top.val)
        if top.subIdx + 1 < a[top.idx].count {
            // 继续取该元素对应的数组中的下一个元素，入队列
            let item = (val: a[top.idx][top.subIdx+1], idx: top.idx, subIdx: top.subIdx+1)
            queue.enqueue(value: item)
        }
    }
    return res
}

let array1 = [1, 2, 6, 15, 17, 21, 23, 33]
let array2 = [7, 8, 9, 13, 16]
let array3 = [5, 10, 12, 14]

let res = mergeKArrays([array1, array2, array3], <)
print(res)
