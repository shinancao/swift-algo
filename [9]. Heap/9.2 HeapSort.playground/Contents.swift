import Foundation

let array = [ 25, 13, 20, 8, 7, 17, 2, 5, 4 ]

let sortedArray = heapSort(array, <)
print(sortedArray)

let sortedArray2 = heapSort(array, >)
print(sortedArray2)

