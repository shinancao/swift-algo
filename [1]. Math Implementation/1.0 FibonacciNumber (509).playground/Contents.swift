import Foundation
/**
 509. 斐波那契数
 斐波那契数，通常用 F(n) 表示，形成的序列称为斐波那契数列。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：
 
 F(0) = 0,   F(1) = 1
 F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
 给定 N，计算 F(N)。
 */
class Solution {
    // 时间复杂度为O(2^n)
    func fib1(_ N: Int) -> Int {
        if N == 0 || N == 1 {
            return N
        }
        return fib(N-1) + fib(N-2)
    }
    
    // 时间复杂度为O(n)
    func fib(_ N: Int) -> Int {
        if N < 1 {
            return 0
        }
        // 用一个数组存储计算过的值，初始为0
        var memo = [Int](repeating: 0, count: N + 1)
        return helper(&memo, N)
    }
    
    func helper(_ memo: inout [Int], _ n: Int) -> Int {
        if n == 1 || n == 2 {
            return 1
        }
        
        if memo[n] != 0 {
            return memo[n]
        }
        // 如果没有计算过，递归的过程和之前一样
        memo[n] = helper(&memo, n - 1) + helper(&memo, n - 2)
        return memo[n]
    }
}

let solution = Solution()
let res = solution.fib(4)
print(res)
