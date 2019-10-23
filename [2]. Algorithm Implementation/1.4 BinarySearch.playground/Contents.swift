import Foundation

class BinarySearch {
    /// 二分查找给定值的index
    public static func bsearch(_ a: [Int], value: Int) -> Int? {
        var low = 0
        var high = a.count - 1
        // 注意此处的循环条件是low<=high，而不是low<high
        while low <= high {
            // 注意此处不要用(low+high)/2计算mid值，可能会益处
            let mid = low + (high - low)/2
            if a[mid] == value {
                return mid
            } else if a[mid] < value {
                // 注意此处的取值是mid+1而不是mid
                low = mid + 1
            } else {
                // 注意此处的取值是mid-1而不是mid
                high = mid - 1
            }
        }
        return nil
    }
    /// 二分查找第一个等于给定值的index
    public static func bsearch1(_ a: [Int], value: Int) -> Int? {
        var low = 0
        var high = a.count - 1
        while low <= high {
            // 左移1位相当于乘以2，右移1位相当于除以2
            let mid = low + ((high - low) >> 1)
            if a[mid] == value {
                // 继续向前找，看还有没有等于给定值的
                if mid == 0 || a[mid-1] != value {
                    return mid
                } else {
                    high = mid - 1
                }
            } else if a[mid] < value {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return nil
    }
    /// 二分查找最后一个等于给定值的index
    public static func bsearch2(_ a: [Int], value: Int) -> Int? {
        var low = 0
        var high = a.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if a[mid] == value {
                if mid == a.count-1 || a[mid+1] != value {
                    return mid
                } else {
                    low = mid + 1
                }
            } else if a[mid] < value {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return nil
    }
    /// 查找第一个大于等于给定值的元素
    public static func bsearch3(_ a: [Int], value: Int) -> Int? {
        var low = 0
        var high = a.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if a[mid] < value {
                low = mid + 1
            } else {
                if mid == 0 || a[mid-1] < value {
                    return mid
                } else {
                    high = mid - 1
                }
            }
        }
        return nil
    }
    /// 查找最后一个小于等于给定值的元素
    public static func bsearch4(_ a: [Int], value: Int) -> Int? {
        var low = 0
        var high = a.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if a[mid] > value {
                high = mid - 1
            } else {
                if mid == a.count-1 || a[mid+1] > value {
                    return mid
                } else {
                    low = mid + 1
                }
            }
        }
        return nil
    }
}
let a = [8, 11, 19, 23, 27, 33, 45, 55, 67, 98]
let index = BinarySearch.bsearch(a, value: 19)
print(index!)
let b = [1, 3, 4, 5, 6, 8, 8, 8, 11, 18]
let first = BinarySearch.bsearch1(b, value: 18)
print(first!)
let last = BinarySearch.bsearch2(b, value: 18)
print(last!)
let firstBig = BinarySearch.bsearch3(b, value: 10)
print(firstBig!)
let lastSmall = BinarySearch.bsearch4(b, value: 10)
print(lastSmall!)

