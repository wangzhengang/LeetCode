//
//  main.swift
//  LeetCodeTest
//
//  Created by 王振钢 on 2020/3/24.
//  Copyright © 2020 王振钢. All rights reserved.
//

import Foundation


extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : TimeInterval {
        return self.timeIntervalSince1970
    }

    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : TimeInterval {
        return self.timeIntervalSince1970 * 1000
    }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    
    var head: ListNode?
    var tail: ListNode?
    
    /*
    ///为链表添加一个节点
    func addNodel(_ value: Int) {
        let newNodel = ListNode(value)
        if head != nil {
            tail?.next = newNodel
            tail = newNodel
        } else {
            head = newNodel
            tail = newNodel
        }
    }
    
    ///删除第N个链表节点
    func deleteNode(_ node: ListNode?) {
        if let n = node?.next {
            node?.val = n.val
            node?.next = node?.next?.next
        }
    }
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
//        if n <= 0 {
//            return head
//        }
        let temp = ListNode(-1)
        temp.next  = head
        var first: ListNode?  = temp
        var second: ListNode? = temp
        var index = 1
        while index <= n+1 {
            index += 1
            first = first?.next
        }
        while first != nil {
            first  = first?.next
            second = second?.next
        }
        second?.next = second?.next?.next
        return temp.next
    }
    
    func reversePairs(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
//        var dic = [String : Int]()
        var count = 0
        for i in 0..<nums.count-1 {
            let iIndex = nums.index(nums.startIndex, offsetBy: i)
            let iValue = nums[iIndex]
            for j in i+1..<nums.count {
                let jIndex = nums.index(nums.startIndex, offsetBy: j)
                let jValue = nums[jIndex]
                if iValue > jValue  {
//                    dic["\(iValue)\(jValue)"] = 1
                    count += 1
                }
            }
        }
        return  count
    }
    
    ///罗马数字转阿拉伯10进制数字
    func romanToInt(_ s: String) -> Int {
        
        if s.isEmpty {
            return 0
        }
        
        var sum = 0
        var i = 0
        while i < s.count {
            
            let crnIndex = s.index(s.startIndex, offsetBy: i)
            let crnChar  = s[crnIndex]
            
            if i != s.count - 1  {
                
                let nxtIndex = s.index(s.startIndex, offsetBy: i+1)
                let nxtChar  = s[nxtIndex]
                
                let str = "\(crnChar)\(nxtChar)"
                switch str {
                case "IV": sum += 4   ; i += 2 ; continue
                case "IX": sum += 9   ; i += 2 ; continue
                case "XL": sum += 40  ; i += 2 ; continue
                case "XC": sum += 90  ; i += 2 ; continue
                case "CD": sum += 400 ; i += 2 ; continue
                case "CM": sum += 900 ; i += 2 ; continue
                default  : break
                }
                
            }
            switch "\(crnChar)" {
            case "I": sum += 1
            case "V": sum += 5
            case "X": sum += 10
            case "L": sum += 50
            case "C": sum += 100
            case "D": sum += 500
            case "M": sum += 1000
            default : break
            }
            i += 1
        }
        
        return sum
    }
    
    ///有效的括号
    func isValid(_ s: String) -> Bool {
        
        var stack = [String]()
        let standard = [")":"(", "]":"[","}":"{"]
        for c in s {
            let t = standard[String(c)]
            if t == nil {
                stack.append(String(c))
            } else if stack.count == 0 || t != stack.popLast() {
                return false
            }
        }

        return stack.count == 0
    }
    
    ///反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        let new = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
        return new
    }
    
    ///合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var l1 = l1
        var l2 = l2
        
        let new = ListNode(0)
        var temp = new
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                temp.next = l1
                l1 = l1?.next
            } else {
                temp.next = l2
                l2 = l2?.next
            }
            temp = temp.next!
        }
        
        temp.next = ( l1 == nil ? l2 : l1)
        
        return new.next
    }
    
    ///是否回文链表
    func isPalindrome(_ head: ListNode?) -> Bool {
        
        if head == nil {
            return false
        }

        var head = head
        var temp = head
        var tail: ListNode?
        var count = 0
        while temp != nil {
            if let v = temp?.val , tail == nil {
                tail = ListNode(v)
            } else if let v = temp?.val {
                let t  = ListNode(v)
                t.next = tail
                tail   = t
            }
            temp = temp?.next
            count += 1
        }
        var i = 0
        while i < count/2 {
            if head?.val != tail?.val {
                return false
            }
            head = head?.next
            tail = tail?.next
            i += 1
        }
        
        return true
    }
    
    ///整数转罗马数字
    func intToRoman(_ num: Int) -> String {
        
        let numbers  = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let luomastr = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        
        var i = 0
        var luoma = ""
        var n = num
        while n != 0 {
            let index = numbers.index(numbers.startIndex, offsetBy: i)
            while n >= numbers[index] {
                n -= numbers[index]
                luoma.append(contentsOf: luomastr[index])
            }
            i += 1
        }

        return luoma
    }
    
    ///盛最多水的容器
    func maxArea(_ height: [Int]) -> Int {
        
        var area = 0
        var i = 0
        var j = height.count - 1
        while i < j {
            let minHeight = min(height[i], height[j])
            let curArea = ( j - i ) * minHeight
            area = max(area, curArea)
            
            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }
        return area
    }
    
    ///环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        
        var head = head
        var map = [ListNode]()
        while head != nil {
            
            if map.contains(where: { $0 === head }) {
                return true
            } else {
                map.append(head!)
            }
            head = head?.next
        }
        
        return false
    }
    
    ///回文数
    func isPalindrome(_ x: Int) -> Bool {
        
        if x < 0 {
            return false
        }
        var r = 0
        var y = x
        while y > 0 {
            r = y % 10 + r * 10
            y = y / 10
        }
        
        return (r == x)
    }
    
    ///数组中数字出现的次数
    func singleNumbers(_ nums: [Int]) -> [Int] {
        
        var count = [Int: Int]()
        for n in nums {
            if let _ = count[n] {
                count.removeValue(forKey: n)
            } else {
                count[n] = 1
            }
        }
        if count.count == 2 {
            return [Int](count.keys)
        }
        return []
    }
    
    ///只出现一次的数字 II
    func singleNumber(_ nums: [Int]) -> Int {
        var f = [Int: Int]()
        for n in nums {
            if let v = f[n], v == 2 {
                f.removeValue(forKey: n)
            } else {
                if let v = f[n] {
                    f[n] = v + 1
                } else {
                    f[n] = 1
                }
            }
        }
        if f.count == 1, let k = f.first {
            return k.key
        }
        return 0
    }
    
    
    ///只出现一次的数字 II
    func singleNumber2(_ nums: [Int]) -> Int {
        var one = 0
        var two = 0
        for n in nums {
            one = ~two & ( one ^ n)
            two = ~one & ( two ^ n)
        }
        return one
    }
    
    
    ///只出现一次的数字 III
    func singleNumber3(_ nums: [Int]) -> [Int] {
        var f = [Int: Int]()
        for n in nums {
            if let _ = f[n] {
                f.removeValue(forKey: n)
            } else {
                f[n] = 1
            }
        }
        return Array( f.keys )
    }

    
    ///两两交换链表中的节点
    func swapPairs(_ head: ListNode?) -> ListNode? {
        
//        if head == nil || head?.next == nil {
//            return head
//        }
//
//        let firstNode = head
//        let secondNode = head?.next
//
//        firstNode?.next = swapPairs(secondNode?.next)
//        secondNode?.next = firstNode
//
//        return secondNode
        
        var head = head
        let dummy = ListNode(-1)
        dummy.next = head
        var preNodel = dummy
        while head != nil && head?.next != nil {
            let first = head
            let second = head?.next
            
            preNodel.next = second
            first?.next = second?.next
            second?.next = first
            
            preNodel = first!
            head = first?.next
        }
        return dummy.next
        
    }
//    0->1->2->3->4
    
//    2->1->4->3->5->6
                
    ///电话号码的字母组合
    func letterCombinations(_ digits: String) -> [String] {
        
        if digits.count < 2 {
            return []
        }
        
//        let keyboard: [String: [String]] = ["2":["a","b","c"], "3":["d","e","f"], "4":["g","h","i"], "5":["j","k","l"], "6":["m","n","o"], "7":["p","q","r","s"], "8":["t","u","v"], "9":["w","x","y","z"]]
        
//        for item in digits {
//            let n = String(item)
            
            
//        }
        return []
    }
    
    ///快乐数，迭代
    func isHappy(_ n: Int) -> Bool {
        
        if n <= 0 {
            return false
        }
        
        var map = [Int: Int]()
        var n = n
        var result = 0
        while result != 1 {
            result = 0
            result = remainderSquare(n)
            if let _ = map[result] {
                break
            } else {
                map[result] = 1
            }
            n = result
        }
        
        return (result == 1)
    }
    func remainderSquare(_ n: Int) -> Int {
        var n = n
        var result = 0
        while n != 0 {
            let remainder = n % 10
            n /= 10
            result += remainder * remainder
        }
        return result
    }
    ///快乐数，快慢指针
    func isHappy1(_ n: Int) -> Bool {
        
        var slow = n
        var fast = remainderSquare(n)
        
        while fast != 1 && slow != fast {
            slow = remainderSquare(slow)
            fast = remainderSquare(remainderSquare(fast))
        }
        
        return (fast == 1)
    }
    
    ///移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        
        var nums = nums
        
        
        
        return nums.count
    }
    
    ///外观数列
    func countAndSay(_ n: Int) -> String {
        
        if n < 1 && n > 30 {
            return "error"
        }
        
        if n == 1 {
            return "1"
        }

        var s = "1"
        var r = ""
        
        var i = 1
        while i != n {
            i += 1
            
            while !s.isEmpty {
                
                if (s.hasPrefix("111")) {
                    s.removeFirst(3)
                    r.append(contentsOf: "31")
                } else if (s.hasPrefix("11")) {
                    s.removeFirst(2)
                    r.append(contentsOf: "21")
                } else if s.hasPrefix("1") {
                    s.removeFirst()
                    r.append(contentsOf: "11")
                } else if (s.hasPrefix("222")) {
                    s.removeFirst(3)
                    r.append(contentsOf: "32")
                } else if (s.hasPrefix("22")) {
                    s.removeFirst(2)
                    r.append(contentsOf: "22")
                } else if (s.hasPrefix("2")) {
                    s.removeFirst()
                    r.append(contentsOf: "12")
                } else if (s.hasPrefix("333")) {
                    s.removeFirst(3)
                    r.append(contentsOf: "33")
                } else if (s.hasPrefix("33")) {
                    s.removeFirst(2)
                    r.append(contentsOf: "23")
                } else if (s.hasPrefix("3")) {
                    s.removeFirst()
                    r.append(contentsOf: "13")
                }
            }
            
            if i != n {
                s = r
                r = ""
            }
            
        }
        
        return r
    }
    
    var map = [Int: String]()
    func countAndSay1(_ n: Int) -> String {
        var r = ""
        if let v = map[n] {
            return v
        } else if n == 1 {
            return "1"
        } else if n == 2 {
            return "11"
        } else {
            var count = 1
            let pre = countAndSay1(n-1)
            for i in 0..<pre.count {
                let cur = pre.index(pre.startIndex, offsetBy: i)
                let nxt = pre.index(pre.startIndex, offsetBy: i+1)
                if( i+1 == pre.count || pre[cur] != pre[nxt] ) {
                    r += "\(count)\(pre[cur])"
                    count = 1
                } else {
                    count += 1
                }
            }
        }
        map[n] = r
        return r
    }
    ///全排列
    var res = [[Int]]()
    func permute(_ nums: [Int]) -> [[Int]] {
        backtrack(nums, track: [Int]())
        return res
    }
    
    func backtrack(_ nums: [Int], track:[Int] ) {
        var track = track
        if track.count == nums.count {
            res.append(track)
            return
        }
        for i in 0..<nums.count {
            if track.contains(nums[i]) {
                continue
            }
            track.append(nums[i])
            backtrack(nums, track: track)
            track.removeLast()
        }
    }
    
    ///组合总和
    var sums = [Int]()
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        var temp = target
        var sums = [[Int]]()
        var sub  = [Int]()
        var index = 0
        var pre  = 0
        while index < candidates.count {
            let cur = candidates[index]
            if  cur == temp {
                sub.append(temp)
                sums.append(sub)
                sub.removeAll()
                temp = target
            } else if cur < temp {
                temp -= cur
                sub.append(cur)
                pre = index
                if candidates.contains(temp) {
                    index = candidates.firstIndex(of: temp)!
                    sub.append(temp)
                    sums.append(sub)
                    sub.removeAll()
                    temp = target
                } else {
                    index = 0
                    continue
                }
            }
            if index == candidates.count - 1 {
                pre += 1
                index = pre
                temp = target
                sub.removeAll()
                continue
            }
            index += 1
        }
        
        
        return sums
    }
    func combinationSumTrack(_ candidates: [Int], _ target: inout Int) {
//        if candidates.contains(target) {
//            sums.append(target)
//            target -= target
//            return
//        }
        for i in 0..<candidates.count {
            target -= candidates[i]
            if target > 0 {
                sums.append(target)
                combinationSumTrack(candidates, &target)
            }
        }
    }
    
    
    ///最低票价
//    func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
//
//    }
    
    ///合并两个有序数组
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if nums2.isEmpty {
            return
        }
        if nums1.isEmpty {
            nums1 = nums2
            return
        }
        var i = 0
        var j = 0
        while i < nums1.count-1 && j < nums2.count {
            if nums1[i] == 0 {
                nums1[i] = nums2[j]
            } else if nums1[i] <= nums2[j] && nums2[j] < nums1[i + 1] {
                for p in (i..<nums1.count-1).reversed() {
                    nums1[p + 1] = nums1[p]
                }
                nums1[i] = nums2[j]
            }
            i += 1
            j += 1
        }
    }
    
    ///三数之和
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {
            return []
        }
        let nums = nums.sorted()
        var result = [[Int]]()
        var i = 0
        while i < nums.count {
            if nums[i] > 0 {
                break
            }
            if i > 0 && nums[i] == nums[i-1] {
                i += 1
                continue
            }
            var l = i + 1
            var r = nums.count - 1
            while l < r {
                let sum = nums[i] + nums[l] + nums[r]
                if sum == 0 {
                    result.append([nums[i], nums[l], nums[r]])
                    while l < r && nums[l] == nums[l + 1] {
                        l += 1
                    }
                    while l < r && nums[r] == nums[r - 1] {
                        r -= 1
                    }
                    r -= 1
                    l += 1
                } else if sum < 0 {
                    l += 1
                } else if sum > 0 {
                    r -= 1
                }
            }
            i += 1
        }
        return result
    }
    
    
    func mySqrt(_ x: Int) -> Int {
        return Int(sqrt(Double(x)))
    }
    
    ///搜索插入位置
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        let array = nums.filter { $0 < target }
        return array.count
    }
    
    ///缺失数字
    func missingNumber(_ nums: [Int]) -> Int {
        var indexSum = 0
        var numsSum = 0
        for i in 0...nums.count {
            indexSum += i
            numsSum += (i < nums.count ? nums[i] : 0)
        }
        return indexSum - numsSum
    }
    
    ///缺失数字
    func missingNumber2(_ nums: [Int]) -> Int {
        var v = nums.count
        for i in 0..<nums.count {
            v ^=  i ^ nums[i]
        }
        return v
    }
    
    ///Fizz Buzz
    func fizzBuzz(_ n: Int) -> [String] {
        if n <= 0 {
            return []
        }
        var s = [String]()
        for i in 1...n {
            if i % 3 == 0 && i % 5 == 0 {
                s.append("FizzBuzz")
            } else if i % 3 == 0 {
                s.append("Fizz")
            } else if i % 5 == 0 {
                s.append("Buzz")
            } else {
                s.append(String(i))
            }
        }
        return s
    }
    
    ///2. 两数相加
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var l1 = l1
        var l2 = l2
        let new = ListNode(-1)
        var head = new
        var bit = 0
        while l1 != nil && l2 != nil {
            let v1 = l1!.val + bit
            let v2 = l2!.val
            if v1 + v2 < 10 {
                bit = 0
                head.next = ListNode(v1 + v2)
            } else {
                bit = 1
                head.next = ListNode((v1 + v2) % 10)
            }
            if bit == 1 {
                if l1?.next == nil {
                    l1?.next = ListNode(bit)
                    bit = 0
                } else if ( l2?.next == nil) {
                    l2?.next = ListNode(bit)
                    bit = 0
                }
            }
            if let n = head.next {
                head = n
            }
            l1 = l1?.next
            l2 = l2?.next
        }
        if l1 != nil {
            l1?.val += bit
            head.next = l1
            bit = 0
        }
        if l2 != nil {
            l2?.val += bit
            head.next = l2
            bit = 0
        }
        if bit != 0 {
            head.next = ListNode(bit)
        }
        return new.next
    }
    
    ///和为K的子数组
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        var pre = 0
        var map = [Int: Int]()
        map[0] = 1
        for i in 0..<nums.count {
            pre += nums[i]
            if let v = map[pre-k] {
                count += v
            }
            if let v = map[pre] {
                map[pre] = v + 1
            } else {
                map[pre] = 1
            }
        }
        return count
    }
    
    ///724. 寻找数组的中心索引
    func pivotIndex(_ nums: [Int]) -> Int {
        var leftSum = 0
        var rightSum = 0
        for i in 0..<nums.count {
            rightSum += nums[i]
        }
        for i in 0..<nums.count {
            if leftSum == rightSum - nums[i] - leftSum {
                return i
            }
            leftSum += nums[i]
        }
        return -1
    }
    
    ///面试题 01.02. 判定是否互为字符重排
    func CheckPermutation(_ s1: String, _ s2: String) -> Bool {
        if s1.count != s2.count {
            return false
        }
        let paris1 = s1.map { ($0, 1) }
        let dic1 = Dictionary(paris1, uniquingKeysWith: +)
        let paris2 = s2.map { ($0, 1) }
        let dic2 = Dictionary(paris2, uniquingKeysWith: +)
        if dic1.count != dic2.count {
            return false
        }
        return (dic1 == dic2)
//        for k in dic2.keys {
//            if dic2[k] != dic1[k] {
//                return false
//            }
//        }
//        return true
    }
    
    ///1370. 上升下降字符串
    func sortString(_ s: String) -> String {
        var result = ""
        var source = s.sorted()
        while source.count > 0 {
            var used = [Character: Bool]()
            ///从小到大
            let small = source
            for e in small {
                if let _ = used[e] {
                    
                } else {
                    result.append(e)
                    used[e] = true
                    if let index = source.firstIndex(of: e) {
                        source.remove(at: index)
                    }
                }
            }
            used.removeAll()
            ///从大到小
            let big = source
            for e in big.reversed() {
                if let _ = used[e] {
                    
                } else {
                    result.append(e)
                    used[e] = true
                    if let index = source.lastIndex(of: e) {
                        source.remove(at: index)
                    }
                }
            }
        }
        return result
    }
    
    ///151. 翻转字符串里的单词
    func reverseWords(_ s: String) -> String {
        
//        var array = s.split(separator: " ")
//        array = array.reversed()
//        return array.joined(separator: " ")
        
        if s.count == 1 && s != " " {
            return s
        }
        
        var result = ""
        var pre = -1
        for i in 0..<s.count {
            
            let index = s.index(s.startIndex, offsetBy: i)
            let element = s[index]
            if element == " " {
                if pre == -1 {
                    continue
                } else {
                    result = insertString(result, s, i, pre)
                    pre = -1
                }
            } else {
                if pre == -1 {
                    pre = i
                } else {
                    continue
                }
            }
//            if i == s.count-1 {
//                result = insertString(result, s, i, pre)
//            }
        }
        if result.hasPrefix(" ") {
            let firstIndex = result.index(result.startIndex, offsetBy: 0)
            result.remove(at: firstIndex)
        }
        
        return result
    }
    
    func insertString(_ result: String, _ s: String, _ i: Int, _ pre: Int) -> String {
        var result = result
        let index = s.index(s.startIndex, offsetBy: i)
        let fromIndex = s.index(s.startIndex, offsetBy: pre)
        let temp = (i == s.count-1 ? s[fromIndex...index] : s[fromIndex..<index])
        let firstIndex = result.index(result.startIndex, offsetBy: 0)
        result.insert(contentsOf: temp, at: firstIndex)
        result.insert(contentsOf: " ", at: firstIndex)
        return result
    }
    
    
    ///680. 验证回文字符串 Ⅱ
//   e a b c d c b a
    func validPalindrome(_ s: String) -> Bool {
        
        let array = Array(s)
        var i = 0
        var j = array.count - 1
        
        while i < j {
            let ie = array[i]
            let je = array[j]
            if ie == je {
                i += 1
                j -= 1
            } else {
                var first = true
                var second = true
                var l = i + 1
                var h = j
                while l < h {
                    if array[l] != array[h] {
                        first = false
                        break
                    }
                    l += 1
                    h -= 1
                }
                l = i
                h = j - 1
                while l < h {
                    if array[l] != array[h] {
                        second = false
                        break
                    }
                    l += 1
                    h -= 1
                }
                return first || second
            }
        }
        return true
    }
    
    ///删除排序数组中的重复项 II
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 2 else {
            return nums.count
        }
        var i = 2
        while i < nums.count {
            if nums[i - 2] == nums[i] {
                nums.remove(at: i)
            } else {
                i += 1
            }
        }
            
        return nums.count
    }
    
    ///颜色分类
    func sortColors(_ nums: inout [Int]) {
        var red = 0
        var white = 0
        var blue = 0
        for n in nums {
            switch n {
            case 0: red += 1
            case 1: white += 1
            case 2: blue += 1
            default: break
            }
        }
        var i = 0
        let len = red + white + blue
        while i < len {
            if red > 0 {
                red -= 1
                nums[i] = 0
            } else if white > 0 {
                white -= 1
                nums[i] = 1
            } else if blue > 0 {
                blue -= 1
                nums[i] = 2
            }
            i += 1
        }
    }
    ///三路排序法
    func sortColors2(_ nums: inout [Int]) {
        var l = 0
        var i = 0
        var h = nums.count - 1
        while i <= h {
            if nums[i] == 0 {
//                nums.swapAt(i, l)
                (nums[i], nums[l]) = (nums[l], nums[i])
                i += 1
                l += 1
            } else if nums[i] == 2 {
//                nums.swapAt(i, h)
                (nums[i], nums[h]) = (nums[h], nums[i])
                h -= 1
            } else {
                i += 1
            }
        }
    }
    
    ///  数组中的第K个最大元素
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        return nums.sorted( by: > )[k - 1]
    }
    
    ///两数之和 II - 输入有序数组
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        guard numbers.count > 1 else {
            return []
        }
        
        var map = [Int: Int]()
        for i in 0..<numbers.count {
            map[numbers[i]] = i
        }
        for i in 0..<numbers.count {
            if let v = map[target - numbers[i]], v != i {
                return [i + 1, v + 1]
            }
        }
        return []
    }
    
    ///345. 反转字符串中的元音字母
    func reverseVowels(_ s: String) -> String {
        
        let vowels: [Character: Bool] = ["a": true, "e": true, "i": true, "o": true, "u": true, "A": true, "E": true, "I": true, "O": true, "U": true ];
        var array = Array(s)
        var i = 0
        var j = array.count - 1
        
        while i < j {
            
            while i < array.count, let p = ( vowels[array[i]] == nil ? false : true ), !p {
                i += 1
            }
            
            while j >= 0, let l = ( vowels[array[j]] == nil ? false : true ), !l {
                j -= 1
            }
            if i >= j {
                break
            }
            (array[i], array[j]) = (array[j], array[i])
            i += 1
            j -= 1
        }
        return String(array)
    }
    
    ///长度最小的子数组
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        
        var count = Int.max
        var left = 0
        var sum = 0
        for i in 0..<nums.count {
            sum += nums[i]
            while sum >= s {
                count = min(i-left+1, count)
                sum -= nums[left]
                left += 1
            }
        }
        return ( count == Int.max ? 0 : count )
    }
    
    ///371. 两整数之和
    func getSum(_ a: Int, _ b: Int) -> Int {
        var sum = a ^ b
        var carry = (a & b) << 1
        while carry != 0 {
            (sum, carry) = (sum ^ carry, (sum & carry) << 1)
        }
        return sum
    }
    
    ///字符串的排列
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        if s1.count > s2.count {
            return false
        }
        let s1 = Array(s1)
        let s2 = Array(s2)
        var s1map = Array(repeating: 0, count: 26)
        var s2map = Array(repeating: 0, count: 26)
        for i in 0..<s1.count {
            let aInt = Int((String("a") as NSString).character(at: 0))
            let i1Int = Int((String(s1[i]) as NSString).character(at: 0))
            let i2Int = Int((String(s2[i]) as NSString).character(at: 0))
            s1map[i1Int - aInt] += 1
            s2map[i2Int - aInt] += 1
        }
        for i in 0..<s2.count-s1.count {
            if matches(s1map, s2map) {
                return true
            }
            let aInt = Int((String("a") as NSString).character(at: 0))
            let sInt = Int((String(s2[ i + s1.count ]) as NSString).character(at: 0))
            let iInt = Int((String(s2[i]) as NSString).character(at: 0))
            s2map[sInt - aInt] += 1
            s2map[iInt - aInt] -= 1
        }
        return matches(s1map, s2map)
    }
    func matches(_ s1map: [Int], _ s2map: [Int]) -> Bool {
        for i in 0..<26 {
            if s1map[i] != s2map[i] {
                return false
            }
        }
        return true
    }
    
    ///53. 最大子序和
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return Int(Int32.min)
        }
        var pre = 0, maxSum = nums[0]
        for n in nums {
            pre = max(pre + n, n)
            maxSum = max(maxSum, pre)
        }
        return maxSum
    }
    
    ///152. 乘积最大子数组
    func maxProduct(_ nums: [Int]) -> Int {
        var maxf = nums[0], minf = nums[0], ans = nums[0]
        for i in 1..<nums.count {
            let mx = maxf, mn = minf
            maxf = max(mx * nums[i], max(nums[i], mn * nums[i]))
            minf = min(mn * nums[i], min(nums[i], mx * nums[i]))
            ans = max(maxf, ans)
        }
        return ans
    }
    
    ///697. 数组的度
    func findShortestSubArray(_ nums: [Int]) -> Int {
        var map = [Int: (Int, Int, Int)]()
        for i in 0..<nums.count {
            let n = nums[i]
            if map[n] == nil {
                map[n] = (1, i, i)
            } else {
                let v = map[n]
                map[n] = (v!.0 + 1, v!.1, i)
            }
        }
        let dic = map.sorted(by: { $0.value.0 > $1.value.0 } )
        let fst = dic.first!
        let ftr = dic.filter { $0.value.0 >= fst.value.0 }
        let lst = ftr.sorted(by: { ( $0.value.2 - $0.value.1 ) < ( $1.value.2 - $1.value.1 ) } )
        if let m = lst.first {
            return  (m.value.2 + 1 - m.value.1)
        }
        return 1
    }

    ///287. 寻找重复数
    func findDuplicate(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
        for n in nums {
            if let _ = map[n] {
                return n
            } else {
                map[n] = 1
            }
        }
        return 0
    }
    
    
    ///142. 环形链表 II
    func detectCycle(_ head: ListNode?) -> ListNode? {
        
        var head = head
        var map = [ListNode]()
        while head != nil {
            
            if map.contains(where: { $0 === head }) {
//            if let index = map.firstIndex(where: { $0 === head } ) {
                return head
            } else {
                map.append(head!)
            }
            head = head?.next
        }
        
        return nil
        
        
        /*
        var fast = head?.next
        var slow = head
        while fast != nil, fast?.next != nil {
            if fast === slow {
                return slow
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return nil
        */
    }
    
    ///645. 错误的集合
    func findErrorNums(_ nums: [Int]) -> [Int] {
        
        var result = [Int]()
        var map = [Int: Int]()
        for n in nums {
            if let _ = map[n] {
                result.append(n)
            } else {
                map[n] = 1
            }
        }
        for i in 1...nums.count {
            if map[i] == nil {
                result.append(i)
                break
            }
        }
        return result
    }
    
    ///229. 求众数 II
    func majorityElement(_ nums: [Int]) -> [Int] {
        var map = [Int: Int]()
        for n in nums {
            if let v = map[n] {
                map[n] = v + 1
            } else {
                map[n] = 1
            }
        }
        var result = [Int]()
        for dic in map {
            if dic.value > (nums.count/3) {
                result.append(dic.key)
            }
        }
        return result
    }
    
    ///169. 多数元素
    func majorityElement(_ nums: [Int]) -> Int {
        /*
        var map = [Int: Int]()
        for n in nums {
            if let v = map[n] {
                map[n] = v + 1
            } else {
                map[n] = 1
            }
        }
        for dic in map {
            if dic.value > (nums.count/3) {
                return dic.key
            }
        }
        return -1
        */
        let nums = nums.sorted()
        return nums[nums.count/2]
    }
    
    ///804. 唯一摩尔斯密码词
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let array = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        var set = Set<String>()
        for word in words {
            var morse = ""
            for alph in word {
                let index = Int(alph.asciiValue!)  - 97
                morse.append(contentsOf: array[index])
            }
            set.insert(morse)
        }
        return set.count
    }
    
    ///541. 反转字符串 II
    func reverseStr(_ s: String, _ k: Int) -> String {
        
        let array = Array(s)
        if array.count < k {
            return String(reverseArray(array))
        }
        if s.count >= k && s.count <= 2 * k  {
            let subarray = reverseArray(Array(array[0..<k]))
            return String( subarray + array[k..<array.count])
        }
        return reverseStr(String( array[0..<2*k] ), k) + reverseStr(String( array[2*k..<s.count] ), k)
    }
    
    ///翻转数组
    func reverseArray<T>(_ array: [T]) -> [T] {
        var array = array
        for i in 0..<array.count/2 {
            let temp = array[array.count-i-1]
            array[array.count-i-1] = array[i]
            array[i] = temp
        }
        return array
    }
    
    ///557. 反转字符串中的单词 III
    func reverseWordsIII(_ s: String) -> String {
        let sArray = s.split(separator: " ")
        var rArray = [String]()
        for str in sArray {
            rArray.append(String(str.reversed()))
        }
        return rArray.joined(separator: " ")
    }
    
    ///974. 和可被 K 整除的子数组
    func subarraysDivByK(_ A: [Int], _ K: Int) -> Int {
        
        var m = [Int: Int]()
        m = [0: 1]
        var s = 0
        var c = 0
        for a in A {
            s += a
            let model = ( s % K + K ) % K
            let v = ( m[model] == nil ? 0 : m[model] )
            c += v!
            m[model] = v! + 1
        }
        return c
        
        /*
        var m = Set<Int>()
        var c = 0
        var i = 0
        var j = 0
        while i < A.count {
            var sum = 0
            while i <= j, j < A.count {
                sum += A[j]
                let model = ( sum % K + K ) % K
                if m.contains(model) {
                    c += 1
                } else {
                    if model == 0 {
                        c += 1
                        m.insert(model)
                    }
                }
                j += 1
            }
            i += 1
            j = i
        }
        return c
 */
 
    }
    
    ///1009. 十进制整数的反码
    func bitwiseComplement(_ N: Int) -> Int {
        
        var t = 2
        while t <= N {
            t = t << 1
        }
        return t - N - 1
        
        /*
        let bs = String( N, radix:2)
        var rs = ""
        for s in bs {
            rs.append(contentsOf: ( s == "1" ? "0" : "1"))
        }
        var sum = 0
        for b in rs {
            sum = sum * 2 + Int("\(b)")!
        }
        
        return sum
        */
    }
    
    
    ///477. 汉明距离总和
    func totalHammingDistance(_ nums: [Int]) -> Int {
        /*
        var sum = 0
        for i in 0..<nums.count-1 {
            for j in i+1..<nums.count {
                var t = nums[i] ^ nums[j]
                var count = 0
                while t != 0 {
                    if t & 0x01 == 1 {
                        count += 1
                    }
                    t = t >> 1
                }
                sum += count
            }
        }
        return sum
 */
        if nums.isEmpty {
            return 0
        }
        var ans = 0
        let n = nums.count
        var cnt = Array(repeating: 0, count: 32)
        for num in nums {
            var num = num
            var i = 0
            while num > 0 {
                cnt[i] += (num & 0x01)
                num >>= 1
                i += 1
            }
        }
        for k in cnt {
            ans += k * (n - k)
        }
        return ans
    }
    
    ///461. 汉明距离
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var c = 0
        var x = x
        x = x ^ y
        while x != 0 {
            if x & 0x01 == 1 {
                c += 1
            }
            x >>= 1
        }
        return c
    }
    
    ///191. 位1的个数
    func hammingWeight(_ n: Int) -> Int {
        var c = 0
        var n = n
        while n != 0 {
            if n & 0x01 == 1 {
                c += 1
            }
            n >>= 1
        }
        return c
    }
    
    ///190. 颠倒二进制位
    func reverseBits(_ n: Int) -> Int {
        var baniry = Array( String(n, radix: 2) )
        if baniry.count < 32 {
            let len = 32 - baniry.count
            baniry = Array(repeating: "0", count: len) + baniry
        }
        let count = baniry.count
        for i in 0..<count/2 {
            let t = baniry[count - i - 1]
            baniry[count - i - 1] = baniry[i]
            baniry[i] = t
        }
        var sum = 0
        for b in baniry {
            sum = sum * 2 + Int("\(b)")!
        }
        return sum
    }
    
    ///1287. 有序数组中出现次数超过25%的元素
    func findSpecialInteger(_ arr: [Int]) -> Int {
        var map = [Int: Int]()
        for a in arr {
            if let v = map[a] {
                map[a] = v + 1
            } else {
                map[a] = 1
            }
            if map[a]! > arr.count/4 {
                return a
            }
        }
        return 0
    }
    
    ///1389. 按既定顺序创建目标数组
    func createTargetArray(_ nums: [Int], _ index: [Int]) -> [Int] {
        if nums.count == 0 || index.count == 0 || nums.count != index.count {
            return []
        }
        var target = [Int]()
        var i = 0
        while i < index.count {
            let index = index[i]
            let value = nums[i]
            target.insert(value, at: index)
            i += 1
        }
        return target
    }
    
    ///581. 最短无序连续子数组
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return 0
        }
        let clone = nums.sorted()
        var l = nums.count, r = 0
        for i in 0..<nums.count {
            if clone[i] != nums[i] {
                r = max(r, i)
                l = min(l, i)
            }
        }
        return ( r - l < 0 ? 0 : r - l + 1)
    }
    
    ///394. 字符串解码
    func decodeString(_ s: String) -> String {
        let stack = Stack<String>()
        let cArray = Array(s)
        var i = 0
        while i < cArray.count {
            let c = cArray[i]
            if c == "]" {
                //取出【】内的字符串
                var cnt = ""
                while !stack.isEmpty() {
                    let top = stack.pop()!
                    if ( top == "[" ) {
                        break
                    } else if ( ( top >= "a" && top <= "z" ) || ( top >= "A" && top <= "Z" ) ) {
                        let index = cnt.index(cnt.startIndex, offsetBy: 0)
                        cnt.insert(contentsOf: top, at: index)
                    }
                }
                //取出数字
                var num = ""
                while !stack.isEmpty() {
                    let top = stack.top()!
                    if top >= "0" && top <= "9" {
                        let index = num.index(num.startIndex, offsetBy: 0)
                        num.insert(contentsOf: top, at: index)
                        stack.pop()
                    } else {
                        break
                    }
                }
                //解码
                num = ( num.isEmpty ? "0" : num )
                var j = 0
                var decode = ""
                while j < Int(num)! {
                    decode.append(cnt)
                    j += 1
                }
                //插入stack
                stack.push(decode)
                i += 1
            } else {
                //入栈
                stack.push(String(c))
                i += 1
            }
        }
        ///最后的拼接
        var decode = ""
        while !stack.isEmpty() {
            let top = stack.pop()!
            let index = decode.index(decode.startIndex, offsetBy: 0)
            decode.insert(contentsOf: top, at: index)
        }
        return decode
    }
    
    ///1417. 重新格式化字符串
    func reformat(_ s: String) -> String {
        var nums = [Character]()
        var chts = [Character]()
        for c in s {
            if c >= "0" && c <= "9" {
                nums.append(c)
            } else {
                chts.append(c)
            }
        }
        if abs(Int32(nums.count - chts.count)) > 1 {
            return ""
        }
        if nums.count > chts.count {
            return numCharactre(chts, nums)
        } else {
            return numCharactre(nums, chts)
        }
    }
    func numCharactre(_ short: [Character], _ long: [Character] ) -> String {
        var i = 0
        var append = ""
        while i < short.count {
            append.append(long[i])
            append.append(short[i])
            i += 1
        }
        if i < long.count {
            append.append(long[i])
        }
        return append
    }
    
    ///198. 打家劫舍
    func rob(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        var first = nums[0], second = max( nums[0],  nums[1])
        for i in 2..<nums.count {
            (first, second) = ( second, max(first + nums[i], second) )
        }
        return second
    }
    
    ///213. 打家劫舍II
    func robII(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        if nums.count == 2 {
            return max( nums[0],  nums[1])
        }
        return max(robUntil(Array( nums[0..<nums.count-1] )), robUntil(Array( nums[1..<nums.count] )))
    }
    func robUntil(_ nums: [Int]) -> Int {
        var first = nums[0], second = max( nums[0],  nums[1])
        for i in 2..<nums.count {
            (first, second) = ( second, max(first + nums[i], second) )
        }
        return second
    }
    
    ///337. 打家劫舍 III
    func robIII(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var all = [Int]()
        var floor = [Int]()
        var size = 1
        let q = Queue<TreeNode>()
        q.enqueue(root)
        while !q.isEmpty() {
            let cur = q.dequeue()!
            floor.append(cur.val)
            size -= 1
            
            if cur.left != nil {
                q.enqueue(cur.left)
            }
            if cur.right != nil {
                q.enqueue(cur.right)
            }
            
            if size == 0 {
                let sum = floor.reduce(0, +)
                floor.removeAll()
                all.append(sum)
                size = q.size
            }
        }
        return rob(all)
    }
    
    func robIIII(_ root: TreeNode?) -> Int {
        let result = robInternal(root)
        return max(result[0], result[1])
    }
    func robInternal(_ root: TreeNode?) -> [Int] {
        var result = [0, 0]
        if root == nil {
            return result
        }
        let left = robInternal(root?.left)
        let right = robInternal(root?.right)
        
        result[0] = max(left[0], left[1]) + max(right[0], right[1])
        result[1] = left[0] + right[0] + root!.val
        
        return result
    }
    
    ///1451. 重新排列句子中的单词
    func arrangeWords(_ text: String) -> String {
        let words = text.lowercased().split(separator: " ")
        var sort  = words.sorted(by: { $0.count < $1.count })
        sort[0] = Substring( sort[0].capitalized )
        let result = sort.joined(separator: " ")
        return result
    }
    
    ///459. 重复的子字符串
    func repeatedSubstringPattern(_ s: String) -> Bool {
        var ss = s + s
        ss.removeFirst()
        ss.removeLast()
        return ss.contains(s)
    }
    
    ///1431. 拥有最多糖果的孩子
    func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {
        var maxv = 0
        for c in candies {
            maxv = max(maxv, c)
        }
        var barray = [Bool]()
        for c in candies {
            if c + extraCandies >= maxv {
                barray.append(true)
            } else {
                barray.append(false)
            }
        }
        return barray
    }
    
    ///22. 括号生成
    func generateParenthesis(_ n: Int) -> [String] {
        var res = [String]()
        if n <= 0 {
            return res
        }
        dfs("", n, n, &res)
        return res
    }
    func dfs(_ cur: String, _ left: Int, _ right: Int, _ res: inout [String]) {
        if left == 0, right == 0 {
            res.append(cur)
        }
        
        if left > right {
            return
        }
        if left > 0 {
            dfs(cur + "(", left - 1, right, &res)
        }
        if right > 0 {
            dfs(cur + ")", left, right - 1, &res)
        }
    }
    
    ///两个数组的交集
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let n1 = Set(nums1)
        let n2 = Set(nums2)
        return Array( n1.intersection(n2) )
    }
    
    ///面试题64. 求1+2+…+n
    func sumNums(_ n: Int) -> Int {
        return (n == 0 ? 0 : n + sumNums(n - 1))
    }
    
    ///同构字符串
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        let sArray = Array(s)
        let tArray = Array(t)
        var maps = [Character: Int]()
        var mapt = [Character: Int]()
        var b = -1
        var c = -1
        var i = 0
        while i < sArray.count {
            if let v = maps[sArray[i]] {
                b = v
            } else {
                maps[sArray[i]] = i
                b = i
            }
            
            if let v = mapt[tArray[i]] {
                c = v
            } else {
                mapt[tArray[i]] = i
                c = i
            }
            
            if b != c {
                return false
            }
            
            i += 1
        }
        return true
    }
    
    ///根据字符出现频率排序
    func frequencySort(_ s: String) -> String {
        let paris = s.map { ($0, 1) }
        let map = Dictionary(paris, uniquingKeysWith: +)
        let m = map.sorted { $0.value > $1.value }
        var str = ""
        for dic in m {
            for _ in 1...dic.value {
                str.append(dic.key)
            }
        }
        return str
    }
    
    ///837. 新21点
    func new21Game(_ N: Int,_ K: Int,_ W: Int) -> Double {
        if (K == 0) {
            return 1.0
        }
        var dp = Array(repeating: 0.0, count: K + W + 1)
        var i = K
        while i <= N && i < K + W {
            dp[i] = 1.0;
            i += 1
        }
        dp[K - 1] = 1.0 * Double(min(N - K + 1, W)) / Double(W)
        i = K - 2
        while i >= 0 {
            dp[i] = dp[i + 1] - (dp[i + W + 1] - dp[i + 1]) / Double(W)
            i -= 1
        }
        return dp[0]
    }
    
    ///96. 不同的二叉搜索树
    func numTrees(_ n: Int) -> Int {
        var C = 1
        for i in 0..<n {
            C = C * 2 * (2 * i + 1) / (i + 2);
        }
        return C
    }
    
    ///238. 除自身以外数组的乘积
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var answer = Array(repeating: 0, count: nums.count)
        answer[0] = 1
        for i in 1..<nums.count {
            answer[i] = answer[i - 1] * nums[i - 1]
        }
        var r = 1
        for i in (1...nums.count).reversed() {
            answer[i - 1] = answer[i - 1] * r
            r *= nums[i - 1]
        }
        return answer
    }
    
    ///四数之和
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        guard nums.count >= 4 else {
            return []
        }
        let nums = nums.sorted()
        var result = [[Int]]()
        for i in 0..<nums.count {
            if i > 0 && nums[i] == nums[i-1] {
                continue
            }
            for j in i+1..<nums.count {
                if (j > i + 1 && nums[j] == nums[j - 1]) {
                    continue;
                }
                var l = j + 1
                var r = nums.count - 1
                while l < r {
                    let sum = nums[i] + nums[j] + nums[l] + nums[r]
                    if sum == target {
                        result.append([nums[i], nums[j], nums[l], nums[r]])
                        while l < r && nums[l] == nums[l + 1] {
                            l += 1
                        }
                        while l < r && nums[r] == nums[r - 1] {
                            r -= 1
                        }
                        r -= 1
                        l += 1
                    } else if sum < target {
                        l += 1
                    } else {
                        r -= 1
                    }
                }
            }
        }
        return result
    }
    /*
     
     */
    ///面试题29. 顺时针打印矩阵
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.isEmpty {
            return []
        }
        var result = [Int]()
        let width  = matrix.first!.count - 1
        let height = matrix.count - 1
        var hRange = 0...width
        var vRange = 0...height
        var i = 0
        var j = 0
        
        outer: while true {
            //从左到右
            while vRange.contains(i) && hRange.contains(j) {
                result.append(matrix[i][j])
                if j == hRange.upperBound {
                    if vRange.lowerBound+1 > vRange.upperBound{
                        break outer
                    } else {
                        vRange = vRange.lowerBound+1...vRange.upperBound
                    }
                    i = vRange.lowerBound
                    break
                } else {
                    j += 1
                }
            }
            //从上到下
            while vRange.contains(i) {
                result.append(matrix[i][j])
                if i == vRange.upperBound {
                    if hRange.lowerBound > hRange.upperBound-1 {
                        break outer
                    } else {
                        hRange = hRange.lowerBound...hRange.upperBound-1
                    }
                    j = hRange.upperBound
                    break
                } else {
                    i += 1
                }
            }
            //从右到左
            while hRange.contains(j) {
                result.append(matrix[i][j])
                if j == hRange.lowerBound {
                    if vRange.lowerBound > vRange.upperBound-1 {
                        break outer
                    } else {
                        vRange = vRange.lowerBound...vRange.upperBound-1
                    }
                    i = vRange.upperBound
                    break
                } else {
                    j -= 1
                }
            }
            //从下到上
            while vRange.contains(i) {
                result.append(matrix[i][j])
                if i == vRange.lowerBound {
                    if hRange.lowerBound+1 > hRange.upperBound {
                        break outer
                    } else {
                        hRange = hRange.lowerBound+1...hRange.upperBound
                    }
                    j = hRange.lowerBound
                    break
                } else {
                    i -= 1
                }
            }
        }
        return result
    }
    
    ///448. 找到所有数组中消失的数字
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var result = [Int]()
        let set = Set(nums)
        for i in 1...nums.count {
            let n = nums[i - 1]
            if i != n && !set.contains(i) {
                result.append(i)
            }
        }
        return result
    }
    
    ///442. 数组中重复的数据
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var member = Array(repeating: 0, count: nums.count)
        var result = [Int]()
        for n in nums {
            if member[n - 1] > 0 {
                result.append(n)
            } else {
                member[n - 1] = n
            }
        }
        return result
    }
    
    ///面试题 01.01. 判定字符是否唯一
    func isUnique(_ astr: String) -> Bool {
        return (Set(astr).count == astr.count)
    }
    
    ///990. 等式方程的可满足性
    func equationsPossible(_ equations: [String]) -> Bool {
        var parent = Array(repeating: 0, count: 26)
        for i in 0..<26 {
            parent[i] = i
        }
        for s in equations {
            let str = Array(s)
            if str[1] == "=" {
                let index1 = Int(str[0].unicodeScalars.first!.value) - 97
                let index2 = Int(str[3].unicodeScalars.first!.value) - 97
                union(&parent, index1, index2)
            }
        }
        for s in equations {
            let str = Array(s)
            if str[1] == "!" {
                let index1 = Int(str[0].unicodeScalars.first!.value) - 97
                let index2 = Int(str[3].unicodeScalars.first!.value) - 97
                if find(parent, index1) == find(parent, index2) {
                    return false
                }
            }
        }
        return true
    }
    
    func union(_ parent: inout [Int], _ index1: Int, _ index2: Int ) {
        parent[find(parent, index1)] = find(parent, index2)
    }
    
    func find(_ parent: [Int], _ index: Int) -> Int {
        var parent = parent
        var index  = index
        while parent[index] != index {
            parent[index] = parent[parent[index]]
            index = parent[index]
        }
        return index
    }
    
    ///面试题46. 把数字翻译成字符串
    func translateNum(_ num: Int) -> Int {
        let nums = Array(String(num))
        var p = 0, q = 0, r = 1
        for i in 0..<nums.count {
            p = q
            q = r
            r = 0
            r += q
            if i == 0 {
                continue
            }
            let n = Int("\(nums[i-1])\(nums[i])")!
            if n >= 10 && n <= 25 {
                r += p
            }
        }
        return r
    }
    
    ///面试题62. 圆圈中最后剩下的数字
    func lastRemaining(_ n: Int, _ m: Int) -> Int {
        var f = 0
        for i in 2..<n+1 {
            f = (m + f) % i
        }
        return f
    }
    
    ///796. 旋转字符串
    func rotateString(_ A: String, _ B: String) -> Bool {
        return (A.count == B.count) && ((A + A).contains(B) || (A.isEmpty && B.isEmpty))
    }
    
    ///520. 检测大写字母
    func detectCapitalUse(_ word: String) -> Bool {
        if word.count == 1 {
            return true
        }
        var upperCount = 0
        for w in word {
            if w.isUppercase {
                upperCount += 1
            }
        }
        switch upperCount {
        case 0: fallthrough
        case 1 where word[word.startIndex].isUppercase : fallthrough
        case word.count: return true
        default: return false
        }
    }
    
    ///1002. 查找常用字符
    func commonChars(_ A: [String]) -> [String] {
        if A.isEmpty {
            return []
        }
        var maps = [[Character: Int]]()
        for s in A {
            var map = [Character: Int]()
            for c in s {
                if let v = map[c] {
                    map[c] = v + 1
                } else {
                    map[c] = 1
                }
            }
            maps.append(map)
        }
        var result = [String]()
        let first = maps.first!
        for key in first.keys {
            
            var all  = true
            var minv = Int(first[key]!)
            for map in maps[1...maps.count-1] {
                if let v = map[key]  {
                    minv = min(minv, v)
                } else {
                    all = false
                }
            }
            if all == true && minv > 0 && minv != Int.max {
                let array = Array(repeating: String(key), count: minv)
                result.append(contentsOf: array)
            }
        }
        return result
    }
    
    ///500. 键盘行
    func findWords(_ words: [String]) -> [String] {
        let line1: Set<Character> = ["q","w","e","r","t","y","u","i","o","p"]
        let line2: Set<Character> = ["a","s","d","f","g","h","j","k","l"]
        let line3: Set<Character> = ["z","x","c","v","b","n","m"]
        var result = [String]()
        for word in words {
            let set = Set<Character>(word.lowercased())
            switch set.count {
            case line1.intersection(set).count: result.append(word)
            case line2.intersection(set).count: result.append(word)
            case line3.intersection(set).count: result.append(word)
            default: break
            }
        }
        return result
    }
    
    ///299. 猜数字游戏
    func getHint(_ secret: String, _ guess: String) -> String {
        let secret = Array(secret)
        let guess = Array(guess)
        var a = 0
        var b = 0
        var mapS = Array(repeating: 0, count: 10)
        var mapG = Array(repeating: 0, count: 10)
        for i in 0..<secret.count {
            if secret[i] == guess[i] {
                a += 1
            } else {
                mapS[Int(String(secret[i]))!] += 1
                mapG[Int(String(guess[i]))!] += 1
            }
        }
        for i in 0..<10 {
            b += min(mapG[i], mapS[i])
        }
        return "\(a)A\(b)B"
    }
    
    ///739. 每日温度
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        if T.count <= 1 {
            return [0]
        }
        var r = Array(repeating: 0, count: T.count)
        let stack = Stack<Int>()
        for i in 0..<T.count {
            while !stack.isEmpty() && T[i] > T[stack.top()!] {
                let p = stack.pop()!
                r[p] = i - p
            }
            stack.push(i)
        }
        return r
    }
    
    ///496. 下一个更大元素 I
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var map = [Int: Int]()
        for i in 0..<nums2.count {
            map[nums2[i]] = i
        }
        
        var r = [Int]()
        for i in 0..<nums1.count {
            var all = true
            for j in map[nums1[i]]!..<nums2.count {
                if nums2[j] > nums1[i] {
                    r.append(nums2[j])
                    all = false
                    break
                }
            }
            if all {
                r.append(-1)
            }
        }
        return r
    }
    
    ///503. 下一个更大元素 II
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: nums.count)
        let stack = Stack<Int>()
        for i in (0..<2*nums.count).reversed() {
            while !stack.isEmpty() && stack.top()! <= nums[i % nums.count]  {
                stack.pop()
            }
            result[i % nums.count] = (stack.isEmpty() ? -1 : stack.top()!)
            stack.push(nums[i % nums.count])
        }
        return result
    }
    
    ///15. 三数之和，第2遍
    func threeSum2(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        var m = [Int: Int]()
        for n in nums {
            if let v = m[n] {
                m[n] = v + 1
            } else {
                m[n] = 1
            }
        }
        var s = Set<[Int]>()
        var i = 0
        var j = 1
        while i < nums.count - 1{
            let c = -( nums[i] + nums[j] )
            if let v = m[c], v == 1, c != nums[i] , c != nums[j] {
                m.removeValue(forKey: c)
                s.insert([nums[i], nums[j], c].sorted())
            } else if let v = m[c], v > 1 {
                m[c] = 1
                s.insert([nums[i], nums[j], c].sorted())
            }
            if j < nums.count - 1 {
                j += 1
            } else {
                i += 1
                j = i + 1
            }
        }
        return Array(s)
    }
    
    ///1089. 复写零
    func duplicateZeros(_ arr: inout [Int]) {
        let count = arr.count
        var i = 0
        while i < count {
            if arr[i] == 0{
                arr.insert(0, at: i + 1)
                i = i + 2
                arr.removeLast()
            } else {
                i += 1
            }
        }
    }
    
    ///985. 查询后的偶数和
    func sumEvenAfterQueries(_ A: [Int], _ queries: [[Int]]) -> [Int] {
        var A = A
        var r = [Int]()
        var sum = 0
        for a in A {
            if a % 2 == 0 {
                sum += a
            }
        }
        for q in queries {
            let v = q.first!
            let i = q.last!
            //之前是偶数，
            if A[i] % 2 == 0 {
                //加上变成偶数
                if (A[i] + v) % 2 == 0 {
                    sum += v
                } else {
                    sum -= A[i]
                }
            }
            //之前不是偶数
            else {
                //加上变成偶数
                if (A[i] + v) % 2 == 0 {
                    sum = sum + A[i] + v
                }
            }
            A[i] += v
            r.append(sum)
        }
        return r
    }
    
    ///14. 最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.isEmpty {
            return ""
        }
        if strs.count == 1 {
            return strs.first!
        }
        var result = ""
        let first = Array(strs.first!)
        for c in first {
            var isAll = true
            for s in strs {
                if !s.hasPrefix("\(result)\(c)") {
                    isAll = false
                    break
                }
            }
            if isAll {
                result.append(c)
            }
        }
        return result
    }
    
    ///面试题03. 数组中重复的数字
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var set = Set<Int>()
        for n in nums {
            if set.contains(n) {
                return n
            } else {
                set.insert(n)
            }
        }
        return -1
    }
    
    ///面试题04. 二维数组中的查找
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.isEmpty || matrix[0].isEmpty {
            return false
        }
        let n = matrix.count - 1
        let m = matrix[matrix.count - 1].count - 1
        if target < matrix[0][0] || target > matrix[n][m] {
            return false
        }
        var temp = [[Int]]()
        for i in 0...n {
            if matrix[i][0] <= target {
                temp.append(matrix[i])
            }
        }
        for x in 0..<temp.count {
            let t = temp[x]
            if target > t[m] {
                continue
            }
            for i in (0...m).reversed() {
                if t[i] <= target {
                    for j in x..<temp.count {
                        if temp[j][i] == target {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    ///面试题05. 替换空格
    func replaceSpace(_ s: String) -> String {
//        return s.replacingOccurrences(of: " ", with: "%20")
        var result = ""
        for c in s {
            if c == " " {
                result.append("%20")
            } else {
                result.append(c)
            }
        }
        return result
    }
    
    ///面试题06. 从尾到头打印链表
    func reversePrint(_ head: ListNode?) -> [Int] {
        var head = head
        var result = [Int]()
        while head != nil {
            result.insert(head!.val, at: 0)
            head = head?.next
        }
        return result
    }
    
    ///面试题10- I. 斐波那契数列
    func fib(_ n: Int) -> Int {
//        if n == 0 {
//            return 0
//        }
//        if n == 1 {
//            return 1
//        }
//        return fib(n - 1) + fib(n - 2)
        var n1 = 0
        if n == 0 {
            return n1
        }
        var n2 = 1
        if n == 1 {
            return n2
        }
        for _ in 2...n {
            let t = ( n1 + n2 ) % 1000000007
            n1 = n2
            n2 = t
        }
        return n2
    }
    
    ///面试题11. 旋转数组的最小数字
    func minArray(_ numbers: [Int]) -> Int {
        if numbers.isEmpty {
            return -1
        }
        if numbers.count == 1 {
            return numbers.first!
        }
        var i = 0
        while i < numbers.count - 1 {
            if numbers[i + 1] >= numbers[i] {
                i += 1
            } else {
                return numbers[i + 1]
            }
        }
        return -1
    }
    
    ///1014. 最佳观光组合
    func maxScoreSightseeingPair(_ A: [Int]) -> Int {
        var a = 0, m = A[0] + 0
        for j in 0..<A.count {
            a = max(a, m + A[j] - j)
            m = max(m, A[j] + j)
        }
        return a
    }
    
    
    ///面试题13. 机器人的运动范围
    /// - Parameters:
    ///   - m: 行
    ///   - n: 列
    ///   - k: 目标值
    /// - Returns: 结果
    func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
        if k == 0 {
            return 1
        }
        var conut = 1
        var vis = Array(repeating: Array(repeating: 0, count: n), count: m)
        vis[0][0] = 1
        for i in 0..<m {
            for j in 0..<n {
                if ((i == 0 && j == 0) || weishuhe(i) + weishuhe(j) > k) {
                    continue
                }
                if i - 1 >= 0  {
                    vis[i][j] |= vis[i - 1][j]
                }
                if j - 1 >= 0 {
                    vis[i][j] |= vis[i][j - 1]
                }
                conut += vis[i][j]
            }
        }
        return conut
    }
    func weishuhe(_ n: Int) -> Int {
        var n = n
        var sum = 0
        while n > 0 {
            sum += (n % 10)
            n = n / 10
        }
        return (sum == 0 ? n : sum)
    }
    
    ///面试题14- I. 剪绳子
    func cuttingRope(_ n: Int) -> Int {
        var r = 0
        if n <= 3 {
            r = n - 1
        }
        let a = n / 3, b = n % 3
        if b == 0 {
            r = Int( pow(Double(3), Double(a)) )
        }
        if b == 1 {
            r = Int( pow(Double(3), Double(a - 1))  ) * 4
        }
        r = Int( pow(Double(3), Double(a)) ) * 2
        return r
    }
    
    ///面试题14- II. 剪绳子
    func cuttingRopeII(_ n: Int) -> Int {
        if n <= 3 {
            return n - 1
        }
        var a = n / 3 - 1, b = n % 3, p = 1000000007
        var rem = 1, x = 3
        while a > 0 {
            if a % 2 == 1 {
                rem = (rem * x ) % p
                x = (x * x) % p
            }
            a = a / 2
        }
        if b == 0 {
            return (rem * 3) % p
        }
        if b == 1 {
            return (rem * 4) % p
        }
        return (rem * 6) % p
    }
    
    ///面试题15. 二进制中1的个数
    func hammingWeight2(_ n: Int) -> Int {
        var sum  = 0
        for c in String(n, radix: 2) {
            if c == "1" {
                sum += 1
            }
        }
        return sum
    }
    
    ///面试题16. 数值的整数次方
    func myPow(_ x: Double, _ n: Int) -> Double {
        var x = x
        if x == 0 { return 0 }
        var b = n
        var res: Double = 1.0
        if b < 0 {
            x = 1 / x
            b = -b
        }
        while b > 0 {
            if (( b & 1 ) == 1) {
                res *= x
            }
            x *= x
            b >>= 1
        }
        return res
    }
    
    ///面试题17. 打印从1到最大的n位数
    func printNumbers(_ n: Int) -> [Int] {
        var result = [Int]()
        var count = 1
        for _ in 0..<n {
            count *= 10
        }
        var num = 1
        while num / count == 0 {
            result.append(num)
            num += 1
        }
        return result
    }
    
    ///125. 验证回文串
    func isPalindrome(_ s: String) -> Bool {
        let items = s.map { $0.lowercased() }.filter { ($0 >= "a" && $0 <= "z") || ($0 >= "0" && $0 <= "9") }
        for i in 0..<items.count/2 {
            if items[i] != items[items.count - i - 1] {
                return false
            }
        }
        return true
    }
    
    ///面试题18. 删除链表的节点
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        var tail = head
        if head?.val == val {
            return head?.next
        }
        while tail?.next != nil {
            if tail?.next?.val == val {
                tail?.next = tail?.next?.next
            }
            tail = tail?.next
        }
        return head
    }
    
    ///面试题21. 调整数组顺序使奇数位于偶数前面
    func exchange(_ nums: [Int]) -> [Int] {
        var ji = [Int]()
        var ou = [Int]()
        for i in 0..<nums.count {
            if nums[i] % 2 == 0 {
                ou.append(nums[i])
            } else {
                ji.append(nums[i])
            }
        }
        return ji + ou
    }
    
    ///面试题22. 链表中倒数第k个节点
    func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        var head = head
        var tail = head
        var count = 0
        while tail != nil {
            count += 1
            tail = tail?.next
        }
        var i = 0
        while i != count - k + 1  {
            head = head?.next
            i += 1
        }
        return head
    }
    
    ///面试题24. 反转链表
    func reverseListII(_ head: ListNode?) -> ListNode? {
        var head = head
        var new: ListNode? = nil
        while head != nil {
            let temp = ListNode(head!.val)
            temp.next = new
            new = temp
            head = head?.next
        }
        return new
    }
    
    ///剑指 Offer 25. 合并两个排序的链表
    func mergeTwoListsII(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        var new: ListNode? = nil
        var tail = new
        while l1 != nil && l2 != nil {
            if l1!.val <= l2!.val  {
                if new == nil {
                    new = l1
                    tail = new
                } else {
                    tail?.next = l1
                    tail = tail?.next
                }
                l1 = l1?.next
                tail?.next = nil
            } else {
                if new == nil {
                    new = l2
                    tail = new
                } else {
                    tail?.next = l2
                    tail = tail?.next
                }
                l2 = l2?.next
                tail?.next = nil
            }
        }
        if l1 != nil {
            if new == nil {
                new = l1
            } else {
                tail?.next = l1
            }
        }
        if l2 != nil {
            if new == nil {
                new = l2
            } else {
                tail?.next = l2
            }
        }
        return new
    }
    
    ///剑指 Offer 26. 树的子结构
    func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        return (A != nil && B != nil)  &&  (recur(A, B) || isSubStructure(A?.left, B) || isSubStructure(A?.right, B))
    }
    func recur(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        if B == nil {
            return true
        }
        if A == nil || A?.val != B?.val {
            return false
        }
        return recur(A?.left, B?.left) && recur(A?.right, B?.right)
    }
    
    ///剑指 Offer 27. 二叉树的镜像
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        let left = root?.left
        root?.left = mirrorTree(root?.right)
        root?.right = mirrorTree(left)
        return root
    }
    
    ///剑指 Offer 31. 栈的压入、弹出序列
    func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
        if pushed.isEmpty && popped.isEmpty {
            return true
        }
        if pushed.count != popped.count || pushed.isEmpty || popped.isEmpty {
            return false
        }
        let stack = Stack<Int>()
        var i = 0
        var j = 0
        while i < pushed.count {
            let push = pushed[i]
            stack.push(push)
            while j < popped.count && !stack.isEmpty() {
                let pop = popped[j]
                if stack.top()! == pop {
                    stack.pop()
                    j += 1
                } else {
                    break
                }
            }
            i += 1
        }
        return stack.isEmpty()
    }
    
    ///剑指 Offer 32 - I. 从上到下打印二叉树
    func levelOrder(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var result = [Int]()
        result.append(root!.val)
        let q = Queue<TreeNode>()
        q.enqueue(root)
        var size = q.size
        while !q.isEmpty() {
            let top = q.dequeue()!
            size -= 1
            if let left = top.left {
                q.enqueue(left)
            }
            if let right = top.right {
                q.enqueue(right)
            }
            if size == 0 {
                size = q.size
                for t in q.q {
                    result.append(t.val)
                }
            }
        }
        return result
    }
    
    ///剑指 Offer 32 - II. 从上到下打印二叉树 II
    func levelOrderII(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var result = [[Int]]()
        result.append([root!.val])
        let q = Queue<TreeNode>()
        q.enqueue(root)
        var size = q.size
        while !q.isEmpty() {
            let top = q.dequeue()!
            size -= 1
            if let left = top.left {
                q.enqueue(left)
            }
            if let right = top.right {
                q.enqueue(right)
            }
            if size == 0 && q.size != 0 {
                size = q.size
                var temp = [Int]()
                for t in q.q {
                    temp.append(t.val)
                }
                result.append(temp)
            }
        }
        return result
    }
    
    ///剑指 Offer 32 - III. 从上到下打印二叉树 III
    func levelOrderIII(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var result = [[Int]]()
        result.append([root!.val])
        let q = Queue<TreeNode>()
        q.enqueue(root)
        var size = q.size
        while !q.isEmpty() {
            let top = q.dequeue()!
            size -= 1
            if let left = top.left {
                q.enqueue(left)
            }
            if let right = top.right {
                q.enqueue(right)
            }
            if size == 0 && q.size != 0 {
                size = q.size
                var temp = [Int]()
                for t in q.q {
                    temp.append(t.val)
                }
                if result.count % 2 == 1 {
                    temp.reverse()
                }
                result.append(temp)
            }
        }
        return result
    }
    
    ///67. 二进制求和
    func addBinary(_ a: String, _ b: String) -> String {
        var r = ""
        let ac = Array(a)
        let bc = Array(b)
        var t = 0
        var i = ac.count - 1
        var j = bc.count - 1
        if i >= j  {
            while i >= 0 {
                if j >= 0 {
                    addBinaryJinWei(String(ac[i]), String(bc[j]), &t, &r)
                    j -= 1
                } else {
                    addBinaryJinWei(String(ac[i]), "0", &t, &r)
                }
                i -= 1
            }
        } else {
            while j >= 0 {
                if i >= 0 {
                    addBinaryJinWei(String(ac[i]), String(bc[j]), &t, &r)
                    i -= 1
                } else {
                    addBinaryJinWei("0", String(bc[j]), &t, &r)
                }
                j -= 1
            }
        }
        if t > 0 {
            r.append("1")
        }
        var l = Array(r.reversed())
        while let f = l.first, f == "0", l.count > 1 {
            l.remove(at: 0)
        }
        return String(l)
    }
    func addBinaryJinWei(_ a: String, _ b: String, _ t: inout Int, _ r: inout String) {
        let v = Int(String(a))! + Int(String(b))! + t
        switch v {
        case 0:
            t = 0
            r.append("0")
        case 2:
            t = 1
            r.append("0")
        case 1:
            t = 0
            r.append("1")
        case 3:
            t = 1
            r.append("1")
        default:
            break
        }
    }
    
    ///剑指 Offer 33. 二叉搜索树的后序遍历序列
    func verifyPostorder(_ postorder: [Int]) -> Bool {
        if postorder.count <= 2 {
            return true
        }
        var postorder = postorder
        let last = postorder.removeLast()
        var i = 0
        while i < postorder.count && postorder[i] < last {
            i += 1
        }
        var j = i
        while j < postorder.count && postorder[j] > last {
            j += 1
        }
        var left = true
        if i >= 1 {
            left = verifyPostorder(Array(postorder[0..<i-1]))
        }
        var right = true
        if postorder.count >= i {
            right = verifyPostorder(Array( postorder[i..<postorder.count]))
        }
        return ( j == postorder.count) && left && right
    }
    
    ///剑指 Offer 34. 二叉树中和为某一值的路径
    var rrrr = [[Int]]()
    var temp = [Int]()
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        pathSumWithDiGui(root, sum)
        return rrrr
    }
    func pathSumWithDiGui(_ root: TreeNode?, _ sum: Int) {
        if root == nil {
            return
        }
        temp.append(root!.val)
        let s = sum - root!.val
        if s == 0 && root?.left == nil && root?.right == nil {
            rrrr.append(temp)
        }
        pathSumWithDiGui(root?.left, s)
        pathSumWithDiGui(root?.right, s)
        temp.removeLast()
    }
    
    ///剑指 Offer 42. 连续子数组的最大和
    func maxSubArrayII(_ nums: [Int]) -> Int {
        var nums = nums, maxv = nums[0]
        for i in 1..<nums.count {
            nums[i] += max(nums[i - 1], 0)
            maxv = max(maxv, nums[i])
        }
        return maxv
    }
    
    ///16. 最接近的三数之和
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let nums = nums.sorted()
        let n = nums.count
        var best = 10000000

        // 枚举 a
        for i in 0..<n {
            // 保证和上一次枚举的元素不相等
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue
            }
            // 使用双指针枚举 b 和 c
            var j = i + 1, k = n - 1
            while j < k {
                let sum = nums[i] + nums[j] + nums[k];
                // 如果和为 target 直接返回答案
                if (sum == target) {
                    return target
                }
                // 根据差值的绝对值来更新答案
                if (abs(sum - target) < abs(best - target)) {
                    best = sum
                }
                if (sum > target) {
                    // 如果和大于 target，移动 c 对应的指针
                    var k0 = k - 1
                    // 移动到下一个不相等的元素
                    while j < k0 && nums[k0] == nums[k] {
                        k0 -= 1
                    }
                    k = k0
                } else {
                    // 如果和小于 target，移动 b 对应的指针
                    var j0 = j + 1;
                    // 移动到下一个不相等的元素
                    while j0 < k && nums[j0] == nums[j] {
                        j0 += 1
                    }
                    j = j0
                }
            }
        }
        return best
    }
    
    ///剑指 Offer 50. 第一个只出现一次的字符
    func firstUniqChar(_ s: String) -> Character {
        var map = [Character: Int]()
        var i = 0
        for c in s {
            if let _ = map[c] {
                map[c] = -1
            } else {
                map[c] = i
            }
            i += 1
        }
        var r = [Character: Int]()
        r[" "] = s.count
        for m in map {
            if m.value >= 0 && m.value <= r.values.first! {
                r.removeAll()
                r[m.key] = m.value
            }
        }
        return r.keys.first!
    }
    
    ///剑指 Offer 49. 丑数
    func nthUglyNumber(_ n: Int) -> Int {
        var a = 0, b = 0, c = 0
        var dp = Array(repeating: 1, count: n)
        dp[0] = 1
        for i in 1..<n {
            let n2 = dp[a] * 2, n3 = dp[b] * 3, n5 = dp[c] * 5
            dp[i] = min(min(n2, n3), n5)
            if dp[i] == n2 { a += 1 }
            if dp[i] == n3 { b += 1 }
            if dp[i] == n5 { c += 1 }
        }
        return dp[n - 1]
    }
    
    ///剑指 Offer 53 - I. 在排序数组中查找数字 I
    func search(_ nums: [Int], _ target: Int) -> Int {
        var nums = nums
        var count = 0
        var i = 0
        var j = nums.count - 1
        var m = (i + j) / 2
        while i <= j {
            if nums[m] == target {
                count += 1
                nums.remove(at: m)
                j = ( j >= nums.count ? nums.count - 1 : j )
            } else if nums[m] < target {
                i = m + 1
            } else if nums[m] > target {
                j = m - 1
            }
            m = (i + j) / 2
        }
        return count
    }
    
    ///剑指 Offer 53 - II. 0～n-1中缺失的数字
    func missingNumber3(_ nums: [Int]) -> Int {
        var i = 0, j = nums.count - 1
        while i <= j {
            let m = (i + j) / 2
            if i == nums[m] {
                i = m + 1
            } else {
                j -= 1
            }
        }
        return i
    }
    
    ///剑指 Offer 54. 二叉搜索树的第k大节点
    func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        var array = [Int]()
        kthLargestWithDigui(root, &array, k)
        return array.last!
    }
    func kthLargestWithDigui(_ root: TreeNode?, _ arr: inout [Int], _ k: Int) {
        if root == nil || arr.count == k {
            return
        }
        kthLargestWithDigui(root?.left, &arr, k)
        kthLargestWithDigui(root?.right, &arr, k)
        arr.append(root!.val)
    }
    
    ///215. 数组中的第K个最大元素
    func findKthLargest2(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        var v = (Int.min, 0)
        var i = 0
        while i < k {
            v = (Int.min, 0)
            var j = 0
            while j < nums.count {
                if nums[j] > v.0 {
                    v.0 = nums[j]
                    v.1 = j
                }
                j += 1
            }
            nums.remove(at: v.1)
            i += 1
        }
        return v.0
    }
    
    
    
    ///剑指 Offer 55 - I. 二叉树的深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    ///剑指 Offer 55 - II. 平衡二叉树
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil { return true }
        return abs( maxDepth(root?.left) - maxDepth(root?.right)) <= 1 && isBalanced(root?.left) && isBalanced(root?.right)
    }
    
    ///剑指 Offer 56 - II. 数组中数字出现的次数 II
    func singleNumber_II(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
//        var nums = nums
        var i = 0
        while i < nums.count {
            let n = nums[i]
            if let v = map[n] {
                if v == 1 {
                    map[n] = v + 1
                } else {
                    map.removeValue(forKey: n)
                }
            } else {
                map[n] = 1
            }
            i += 1
        }
        return map.first!.key
    }
    
    ///剑指 Offer 57. 和为s的两个数字
    func twoSum_II(_ nums: [Int], _ target: Int) -> [Int] {
        var i = 0, j = nums.count - 1
        while i != j {
            let s = nums[i] + nums[j]
            if s == target {
                return [nums[i], nums[j]]
            } else if s < target {
                i += 1
            } else if s > target {
                j -= 1
            }
        }
        return []
    }
    
    ///剑指 Offer 57 - II. 和为s的连续正数序列
    func findContinuousSequence(_ target: Int) -> [[Int]] {
        var r = [[Int]]()
        var t = 2;// Int(ceil(Double(target)/2.0))
        var i = 1
        while i < t {
            let sum = (i + t) * (t - i + 1) / 2
            if sum == target {
                var temp = [Int]()
                for i in i...t {
                    temp.append(i)
                }
                r.append(temp)
                i += 1
            } else if sum < target {
                t += 1
            } else {
                i += 1
            }
        }
        return r
    }
    
    ///剑指 Offer 58 - I. 翻转单词顺序
    func reverseWords_IV(_ s: String) -> String {
        return s.split(separator: " ").reversed().joined(separator: " ")
    }
    
    ///剑指 Offer 58 - II. 左旋转字符串
    func reverseLeftWords(_ s: String, _ n: Int) -> String {
        if n >= s.count || n <= 0{
            return s
        }
        var s = s
        let index = s.index(s.startIndex, offsetBy: n - 1)
        let left = s[s.startIndex...index]
        s.removeSubrange(s.startIndex...index)
        s.append(contentsOf: left)
        return s
    }
    
    
    ///378. 有序矩阵中第K小的元素
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var a = [Int]()
        for array in matrix {
            for n in array {
                a.append(n)
            }
        }
        return a.sorted()[k - 1]
    }
    
    ///剑指 Offer 59 - I. 滑动窗口的最大值
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if (nums.isEmpty && k == 0) || k > nums.count {
            return []
        }
        var r = [Int]()
        var i = 0, j = 0, m = Int.min
        while j <= nums.count {
            if j < i + k {
                m = max(m, nums[j])
                j += 1
            } else {
                r.append(m)
                if j == nums.count {
                    break
                }
                m = Int.min
                i += 1
                j = i
            }
        }
        return r
    }
    
    ///剑指 Offer 60. n个骰子的点数
    func twoSum60(_ n: Int) -> [Double] {
        var dp = [Double](repeating: 1 / 6, count: 6)
        guard n > 1 else { return dp }
        //每一轮循环解决i个骰子的情况下出现的概率
        for i in 2...n {
            //i个骰子的点数概率数组长度为 i * 5 + 1
            var tmp = [Double](repeating: 0, count: 5 * i + 1)
            for j in 0..<dp.count {
                for k in 0..<6 {
                    //点数为j+k的情况有可能是点数为j时，再投掷一次产生的
                    tmp[j + k] += dp[j] / 6
                }
            }
            dp = tmp
        }
        return dp
    }
    
    ///剑指 Offer 61. 扑克牌中的顺子
    func isStraight(_ nums: [Int]) -> Bool {
        let nums = nums.sorted()
        var i = 0, count = 0
        while i < nums.count - 1 {
            if nums[i] == 0 {
                count += 1
            } else {
                let s = nums[i + 1] - nums[i]
                if s == 1 {
                    
                } else if s == 0 {
                    return false
                } else {
                    count -= s - 1
                    if count < 0 {
                        return false
                    }
                }
            }
            i += 1
        }
        return true
    }
    
    ///剑指 Offer 62. 圆圈中最后剩下的数字
    func lastRemainingII(_ n: Int, _ m: Int) -> Int {
        var f = 0
        for i in 2...n {
            f = (f + m) % i
        }
        return f
    }
    
    ///剑指 Offer 63. 股票的最大利润
    func maxProfit(_ prices: [Int]) -> Int {
        var c = Int.max, p = 0
        for n in prices {
            c = min(c, n)
            p = max(p, n - c)
        }
        return p
    }
    
    
    ///剑指 Offer 66. 构建乘积数组
    func constructArr(_ a: [Int]) -> [Int] {
        if a.isEmpty {
            return a
        }
        var p = 1
        var i = 0
        var r = [p]
        //下三角
        while i < a.count - 1 {
            p *= a[i]
            r.append(p)
            i += 1
        }
        //上三角
        p = 1
        i = a.count - 1
        while i > 0 {
            p *= a[i]
            r[i - 1] *= p
            i -= 1
        }
        return r
    }
    
    ///剑指 Offer 65. 不用加减乘除做加法
    func add(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while(b != 0) { // 当进位为 0 时跳出
            let c = (a & b) << 1;  // c = 进位
            a ^= b; // a = 非进位和
            b = c; // b = 进位
        }
        return a;
    }
    
    ///剑指 Offer 67. 把字符串转换成整数
    func strToInt(_ str: String) -> Int {
        let c = Array(str.trimmingCharacters(in: [" "]))
        if(c.count == 0) { return 0 }
        var res = 0, bndry = Int.max / 10
        var i = 1, sign = 1
        if(c[0] == "-") { sign = -1 }
        else if(c[0] != "+") { i = 0 }
        for j in i..<c.count {
            if(c[j] < "0" || c[j] > "9" ) { break }
            if(res > bndry || res == bndry && c[j] > "7") { return sign == 1 ? Int(Int32.max) : Int(Int32.min) }
            res = res * 10 + Int((c[j].asciiValue! - Character("0").asciiValue!))
        }
        let r = sign * res
        if r > Int(Int32.max) {
            return Int(Int32.max)
        }
        if r < Int(Int32.min) {
            return Int(Int32.min)
        }
        return r
    }
    
    ///108. 将有序数组转换为二叉搜索树
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return sortedArrayToBSTWithDigui(nums, 0, nums.count - 1)
    }
    func sortedArrayToBSTWithDigui(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        let mid = (left + right) / 2
        let root = TreeNode(nums[mid])
        root.left = sortedArrayToBSTWithDigui(nums, left, mid - 1)
        root.right = sortedArrayToBSTWithDigui(nums, mid + 1, right)
        return root
    }
    
    ///面试题 01.03. URL化
    func replaceSpaces(_ S: String, _ length: Int) -> String {
        if S.isEmpty || length <= 0 || length > S.count {
            return ""
        }
        var i = 0
        var s = Array(S)
        while i < length {
            if s[i] == " " {
                s[i] = Character("%20")
            }
            i += 1
        }
        return String(s[0..<length])
    }
    
    ///面试题 01.04. 回文排列
    func canPermutePalindrome(_ s: String) -> Bool {
        var map = [Character: Int]()
        for c in s {
            map[c] = (map[c] ?? 0) + 1
        }
        var count = 0
        for m in map {
            if m.value % 2 == 1 {
                count += 1
                if count > 1 {
                    return false
                }
            }
        }
        return true
    }
    
    ///面试题 01.06. 字符串压缩
    func compressString(_ S: String) -> String {
        
        var last = Character(" ")
        var result = ""
        var count = 0
        for c in S {
            if c == last {
                count += 1
            } else {
                let t = count > 0 ? "\(count)\(c)" : "\(c)"
                result.append(t)
                count = 1
                last = c
            }
        }
        let t = count > 0 ? "\(count)" : ""
        result.append(t)
        if result.count >= S.count {
            return S
        }
        return result
    }
    
    
    ///面试题 01.07. 旋转矩阵
    func rotate(_ matrix: inout [[Int]]) {
        var result = [[Int]]()
        var i = 0, j = matrix.count - 1
        while i < matrix.count  {
            var row = [Int]()
            while j >= 0 {
                row.append(matrix[j][i])
                j -= 1
            }
            result.append(row)
            i += 1
        }
        matrix = result
    }
    
    ///面试题 01.08. 零矩阵
    func setZeroes(_ matrix: inout [[Int]]) {
        var row = Set<Int>(), clm = Set<Int>()
        var i = 0
        while i < matrix.count {
            var j = 0
            while j < matrix[i].count {
                if matrix[i][j] == 0 {
                    row.insert(i)
                    clm.insert(j)
                    break
                }
                j += 1
            }
            i += 1
        }
        for r in row {
            matrix[r] = Array(repeating: 0, count: matrix[r].count)
        }
        
        for c in clm {
            for r in 0..<matrix.count {
                matrix[r][c] = 0
            }
        }
    }
    
    ///面试题 01.09. 字符串轮转
    func isFlipedString(_ s1: String, _ s2: String) -> Bool {
        return s1.count == s2.count && ((s1.isEmpty && s2.isEmpty) || "\(s1)\(s1)".contains(s2))
    }
    */
    ///112. 路径总和
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        if root == nil {
            return false
        }
        let q = Queue<TreeNode>()
        q.enqueue(root)
        let v = Queue<Int>()
        v.enqueue(root!.val)
        while !q.isEmpty() {
            let top = q.dequeue()
            let num = v.dequeue()!
            if top?.left == nil && top?.right == nil {
                if num == sum {
                    return true
                }
                continue
            }
            if top?.left != nil{
                q.enqueue(top?.left)
                v.enqueue(num + top!.left!.val)
            }
            if top?.right != nil {
                q.enqueue(top?.right)
                v.enqueue(num + top!.right!.val)
            }
        }
        return false
    }
    
    ///面试题 02.01. 移除重复节点
    func removeDuplicateNodes(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var s = Set<Int>()
        var tail = head
        s.insert(tail!.val)
        while tail?.next != nil {
            if let v = tail?.next?.val , s.contains(v) {
                tail?.next = tail?.next?.next
            } else {
                tail = tail?.next
            }
        }
        return head
    }
    
    ///面试题 02.02. 返回倒数第 k 个节点
    func kthToLast(_ head: ListNode?, _ k: Int) -> Int {
        if head == nil || k < 0 {
            return -1
        }
        var count = 0
        var tail = head
        while tail != nil {
            tail = tail?.next
            count += 1
        }
        if k > count {
            return -1
        }
        tail = head
        var i = 0
        while i < count - k {
            i += 1
            tail = tail?.next
        }
        return tail!.val
    }
}

// 1 2  2 1

let s = Solution()

let s1 = Solution()
//s1.addNodel(1)
//s1.addNodel(2)
//s1.addNodel(3)
//s1.addNodel(4)
//s1.addNodel(1)

let s2 = Solution()
//s2.addNodel(1)
//s2.addNodel(2)
//s2.addNodel(3)
s2.head?.next?.next?.next = s2.head
//s2.addNodel(3)
//s2.addNodel(4)
//s2.addNodel(5)


//s.deleteNode( ListNode(5) )  2147483648
var nums1 = [Int]()
var nums2 = [[Int]]()
for i in 1...100000 {
    nums1.append(i)
}
let c = Date().milliStamp
//s.setZeroes( &canshu )
//print(canshu)
let m = Date().milliStamp - c
print(m)







