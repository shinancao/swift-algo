import Foundation

/**
 给定一个整数 n，返回 n! 结果尾数中零的数量。
 
 示例 1:
 
 输入: 3
 输出: 0
 解释: 3! = 6, 尾数中没有零。
 示例 2:
 
 输入: 5
 输出: 1
 解释: 5! = 120, 尾数中有 1 个零.
 说明: 你算法的时间复杂度应为 O(log n) 。
 */
class Solution {
    // 求阶乘，与本题无关
    func fac(_ N: Int) -> Int {
        if N == 0 {
            return 1
        }
        return fac(N-1) * N
    }
    
    // 结果中尾数有0的个数，也就是最终结果有几个10相乘，也就是整个阶乘过程中能拆分出多少个2*5
    // 能拆分出2的个数肯定比5多，所以问题也就变成一系列的数能分解出多少5，有多少个5，就有多少个0
    // 比如25!=1*2*3*4*5*...*25，其中能分解出5的乘数有：
    // 5*10*15*20*25=1*5*2*5*3*5*4*5*5*5 能有5个5，剩余1*2*3*4*5，其中5还能再分解：
    // 5=1*5，有1个5，所以最终0的个数为5+1=6
    func trailingZeroes(_ N: Int) -> Int {
        var sum = 0
        var n = N
        // 时间复杂度为O(log n)
        while n / 5 != 0 {
            sum += n / 5
            n = n / 5
        }
        return sum
    }
    
    // 递归解法
    func trailingZeroes1(_ N: Int) -> Int {
        return helper(N, 0)
    }
    
    func helper(_ n: Int, _ total: Int) -> Int {
        if n < 5 {
            return total
        }
        let count = n / 5
        return helper(count, total + count)
    }
}

let solution = Solution()
var res = solution.fac(10)
print(res)
res = solution.trailingZeroes1(26)
print(res)
