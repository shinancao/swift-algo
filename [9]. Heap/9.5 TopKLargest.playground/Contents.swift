import Foundation

let topKLargest = TopKLargest<Int>(k: 5)
topKLargest.insert(1)
topKLargest.insert(2)
topKLargest.insert(3)
topKLargest.insert(6)
topKLargest.insert(15)
topKLargest.insert(17)
topKLargest.insert(21)

print(topKLargest.elements)

topKLargest.insert(2)
print(topKLargest.elements)
