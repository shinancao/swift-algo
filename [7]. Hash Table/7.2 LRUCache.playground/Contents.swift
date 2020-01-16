import Foundation

/// LRU缓存，即把最近最少使用的移除掉，给新增加的元素让出空间
/// 实现思路，双向链表和散列表结合使用，元素同时存于两个结构表中
/// 利用散列表O(1)的时间复杂度查询到元素，再利用双向链表O(1)的时间复杂度插入和删除元素
/// 在增加和删除元素时要同时维护这两个表
public class LRUCache<Key: Hashable, Value> {
    // 结点里放key-val的元组，以便能获取到key和val
    private typealias Element = (key: Key, val: Value)
    // HashTable和链表中存放的都是Node
    private typealias Node = LinkedList<Element>.LinkedListNode<Element>
    
    private let capacity: Int
    private var cache: HashTable<Key, Node>
    private var priority: LinkedList<Element>
    
    public init(_ capacity: Int) {
        self.capacity = capacity
        self.cache = HashTable<Key, Node>(capacity: capacity)
        self.priority = LinkedList<Element>()
    }
    
    public func get(_ key: Key) -> Value? {
        guard let node = cache[key] else {
            return nil
        }
        
        remove(key)
        insert(key, val: node.value.val)
        
        return node.value.val
    }
    
    public func set(_ key: Key, val: Value) {
        if cache[key] != nil {
            remove(key)
        } else if priority.count >= capacity, let keyToRemove = priority.last?.value.key {
            remove(keyToRemove)
        }
        
        insert(key, val: val)
    }
    
    private func remove(_ key: Key) {
        let node = cache.removeValue(forKey: key)
        if let node = node {
            priority.remove(node)
        }
    }
    
    private func insert(_ key: Key, val: Value) {
        let node = Node(value: (key: key, val: val))
        cache[key] = node
        priority.insert(node, at: 0)
    }
}

// MARK: - Test Cases

let cache = LRUCache<String, Int>(2)
cache.set("a", val: 1)
cache.set("b", val: 2)
cache.get("a")
cache.set("c", val: 3)
cache.get("b")
cache.set("d", val: 4)
cache.get("a")
cache.get("c")
cache.get("d")

