import Foundation

class Node<Key: Hashable, Value> {
    var key: Key?
    var value: Value?
    
    /// 用于连接循环双向列表
    var prev: Node?
    var next: Node?
    /// 用于连接散列表中的拉链
    var hnext: Node?
    
    init() {}
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

class HashTable<Key: Hashable, Value> {
    private var table: [Node<Key, Value>]
    private var use = 0
    
    convenience init() {
        self.init(capacity: 8)
    }
    
    init(capacity: Int) {
        table = [Node<Key, Value>]()
        for _ in 0 ..< capacity {
            // 默认添加哨兵结点
            table.append(Node<Key, Value>())
        }
    }
    
    public func node(forKey key: Key) -> Node<Key, Value>? {
        let index = hash(key)
        var tmp = table[index].hnext
        while tmp != nil {
            if tmp!.key == key {
                return tmp
            }
            tmp = tmp!.hnext
        }
        return nil
    }
    
    public func add(key: Key, node: Node<Key, Value>) {
        let index = hash(key)
        if table[index].hnext == nil {
            table[index].hnext = node
            use += 1
            if use > table.count * 3 / 4 {
                resize()
            }
        } else {
            var tmp = table[index].hnext
            while tmp!.hnext != nil {
                tmp = tmp!.hnext
            }
            tmp!.hnext = node
        }
    }
    
    public func remove(forKey key: Key) {
        let index = hash(key)
        var prev: Node? = table[index]
        var tmp = prev!.hnext
        while tmp != nil {
            if tmp!.key == key {
                prev!.hnext = tmp!.hnext
                break
            }
            prev = tmp
            tmp = tmp!.hnext
        }
    }
    
    private func hash(_ key: Key) -> Int {
        return abs(key.hashValue) % table.count
    }
    
    private func resize() {
        let n = table.count
        for _ in n ..< 2*n {
            table.append(Node<Key, Value>())
        }
    }
}
/// LRU缓存，即把最近最少使用的移除掉，给新增加的元素让出空间
/// 实现思路，双向链表和散列表结合使用，元素同时存于两个结构表中
/// 利用散列表O(1)的时间复杂度查询到元素，再利用双向链表O(1)的时间复杂度插入和删除元素
/// 在增加和删除元素时要同时维护这两个表
class LRUCache<Key: Hashable, Value> : CustomStringConvertible {
    /// 散列表
    private var table: HashTable<Key, Value>
    /// head为哨兵结点，便于将元素插入到头部
    private var head: Node<Key, Value>
    /// tail为哨兵结点，便于移除尾部元素
    private var tail: Node<Key, Value>
    /// 当前双向链表中元素的个数
    private var size = 0
    /// 缓存中可存放的最大元素个数
    private var capacity = 0
    
    init(capacity: Int) {
        self.capacity = capacity
        table = HashTable(capacity: capacity)
        head = Node()
        tail = Node()
        head.next = tail
        tail.prev = head
    }
    
    convenience init () {
        self.init(capacity: 8)
    }
    
    /// 从双向链表中移除一个结点
    private func removeNode(_ node: Node<Key, Value>) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }
    
    /// 添加一个结点到双向链表的头部
    private func addNode(_ node: Node<Key, Value>) {
        node.next = head.next
        head.next?.prev = node
        head.next = node
        node.prev = head
    }
    
    /// 将一个结点移动到头部
    private func moveToHead(_ node: Node<Key, Value>) {
        removeNode(node)
        addNode(node)
    }
    
    private func popTail() -> Node<Key, Value> {
        let node = tail.prev!
        removeNode(node)
        return node
    }
    
    public func add(key: Key, value: Value) {
        let node = table.node(forKey: key)
        if let aNode = node {
            aNode.value = value
            moveToHead(aNode)
        } else {
            let newNode = Node(key: key, value: value)
            table.add(key: key, node: newNode)
            addNode(newNode)
            
            size += 1
            
            if size > capacity {
                // 超过了缓存最大长度，从双向链表的尾部移除一个结点
                let tail = popTail()
                table.remove(forKey: tail.key!)
                size -= 1
            }
        }
    }
    
    public func remove(forKey key: Key) {
        let node = table.node(forKey: key)
        guard node != nil else {
            return
        }
        
        removeNode(node!)
        size -= 1
        table.remove(forKey: key)
    }
    
    public func value(forKey key: Key) -> Value? {
        let node = table.node(forKey: key)
        if let aNode = node {
            moveToHead(aNode)
            return aNode.value!
        } else {
            return nil
        }
    }
    
    var description: String {
        var node = head.next
        var str = String(describing: head.value)
        while node != nil {
            str += "<——>"
            str += String(describing: node!.value)
            node = node!.next
        }
        return str
    }
}

let cache = LRUCache<String, String>(capacity: 10)
cache.add(key: "name", value: "shinancao")
cache.add(key: "email", value: "shinancao666@163.com")
cache.add(key: "sex", value: "female")
print(cache)
let _ = cache.value(forKey: "name")
print(cache)
cache.remove(forKey: "email")
print(cache)
