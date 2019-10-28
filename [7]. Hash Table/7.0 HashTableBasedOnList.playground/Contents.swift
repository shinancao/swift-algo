import Foundation
/// 实现一个用链表法解决散列冲突的散列表
/// 插入的时间复杂度为O(1)
/// 对于散列均匀的散列表来说，查找和删除的时间复杂度为O(k)，k=n/m，n为散列表中数据的个数，m为“槽”的个数
class Node<Key: Hashable, Value> {
    var key: Key?
    var value: Value?
    
    var next: Node?
    
    init() {}
    
    init(key: Key, value: Value, next: Node?) {
        self.key = key
        self.value = value
        self.next = next
    }
}

class HashTable<Key: Hashable, Value>: CustomStringConvertible {
    private var table: [Node<Key, Value>]
    /// 记录table已经使用的个数，以便进行扩容
    private var use = 0
    
    convenience init() {
        self.init(capacity: 8)
    }
    
    init(capacity: Int) {
        // 千万不能这样初始化table，Node是引用类型，这会导致数组中每个位置指向的都是同一个Node
        //        table = [Node<Key, Value>](repeating: Node<Key, Value>(), count: capacity)
        table = [Node<Key, Value>]()
        for _ in 0 ..< capacity {
            // 默认添加哨兵结点
            table.append(Node<Key, Value>())
        }
    }
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    private func value(forKey key: Key) -> Value? {
        let index = hash(key)
        var tmp = table[index].next
        while tmp != nil {
            if tmp!.key == key {
                return tmp!.value
            }
            tmp = tmp!.next
        }
        return nil
    }
    private func updateValue(_ value: Value, forKey key: Key) {
        let index = hash(key)
        if table[index].next == nil {
            // 该位置还没有放元素，创建一个新的放于此处
            table[index].next = Node(key: key, value: value, next: nil)
            use += 1
            if use >= table.count * 3 / 4 {
                resize()
            }
        } else {
            // 使用链表法解决散列冲突
            var tmp = table[index].next
            while tmp!.next != nil {
                // key相等则更新
                if tmp!.key == key {
                    tmp!.value = value
                    return
                }
                tmp = tmp!.next
            }
            // 新放入一个元素
            tmp!.next = Node(key: key, value: value, next: nil)
        }
    }
    private func removeValue(forKey key: Key) {
        let index = hash(key)
        var prev: Node? = table[index]
        var tmp = prev!.next
        while tmp != nil {
            if tmp!.key == key {
                prev!.next = tmp!.next
                break
            }
            prev = tmp
            tmp = tmp!.next
        }
    }
    private func hash(_ key: Key) -> Int {
        // 让其始终返回一个值，可测试散列冲突部分
        return abs(key.hashValue) % table.count
    }
    /// 扩容到原来大小的2倍，一次性将数据散列到新的table中
    /// 但对于Swift来说，table本身就是可以无限往里面增加元素的...
    private func resize() {
        let n = table.count
        for _ in n ..< 2*n {
            table.append(Node<Key, Value>())
        }
    }
    
    var size: Int {
        var num = 0
        for i in 0 ..< table.count {
            var tmp = table[i].next
            while tmp != nil {
                num += 1
                tmp = tmp!.next
            }
        }
        return num
    }
    var isEmpty: Bool {
        return size > 0
    }
    var description: String {
        var str = "["
        for i in 0 ..< table.count {
            var tmp = table[i].next
            while tmp != nil {
                str += "\(tmp!.key!): \(tmp!.value!), "
                tmp = tmp!.next
            }
        }
        str = String(str.dropLast())
        str = String(str.dropLast())
        str += "]"
        return str
    }
}

let table = HashTable<String, String>()
table["name"] = "shinancao"
table["email"] = "shinancao666@163.com"
print(table)
table["name"] = nil
print(table)

