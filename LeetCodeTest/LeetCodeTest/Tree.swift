//
//  Tree.swift
//  LeetCodeTest
//
//  Created by 王振钢 on 2020/6/22.
//  Copyright © 2020 王振钢. All rights reserved.
//

import Foundation



public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
class Solution2 {
    
    ///二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        return height(root)
    }
    
    func height(_ root: TreeNode?) -> Int {
        
        let q = Queue<TreeNode>()
        var height = 0
        var rowSize = 1
        
        q.enqueue(root)
        
        while !q.isEmpty() {
            
            let front = q.dequeue()
            rowSize -= 1
            
            if front?.left != nil {
                q.enqueue(front?.left)
            }
            if front?.right != nil {
                q.enqueue(front?.right)
            }
            
            if rowSize == 0 {//即将访问下一层
                rowSize = q.size
                height += 1
            }
        }
        
        return height
    }
    
    ///层序遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        
        var result = [[Int]]()
        let q = Queue<TreeNode>()
        var rowSize = 1
        
        q.enqueue(root)
        if let r = root {
            result.append([r.val])
        }
        
        while !q.isEmpty() {
            
            let front = q.dequeue()
            rowSize -= 1
            
            if front?.left != nil {
                q.enqueue(front?.left)
            }
            if front?.right != nil {
                q.enqueue(front?.right)
            }
            
            if rowSize == 0 {//即将访问下一层
                rowSize = q.size
                var row = [Int]()
                for i in q.q {
                    row.append(i.val)
                }
                if row.count > 0 {
                    result.append(row)
                }
            }
        }
        return result
    }
    
    ///二叉树的层平均值
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        var result = [Double]()
        let q = Queue<TreeNode>()
        var rowSize = 1
        
        q.enqueue(root)
        if let r = root {
            result.append(Double(r.val))
        }
        
        while !q.isEmpty() {
            
            let front = q.dequeue()
            rowSize -= 1
            
            if front?.left != nil {
                q.enqueue(front?.left)
            }
            if front?.right != nil {
                q.enqueue(front?.right)
            }
            
            if rowSize == 0 {//即将访问下一层
                rowSize = q.size
                var sum = 0
                for i in q.q {
                    sum += i.val
                }
                if rowSize != 0 {
                    let average = Double( sum ) / Double( rowSize )
                    result.append(average)
                }
            }
        }
        return result
    }
    
    ///是否是对称树
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return subTree(root, root)
    }
    
    func subTree(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        if left == nil || right == nil {
            return false
        }
        return (left?.val == right?.val) && subTree(left?.left, right?.right) && subTree(left?.right, right?.left)
    }
    
    ///根据二叉树创建字符串
    var nodeString = ""
    func tree2str(_ t: TreeNode?) -> String {
        preorder(t)
        
        return nodeString
    }

    ///前序遍历
    func preorder(_ root: TreeNode?) {
        if root == nil {
            return
        }
//        print("\(root!.val)")
        nodeString.append("\(root!.val)")
        if root?.left != nil {
            nodeString.append("(")
            preorder(root?.left)
            nodeString.append(")")
        } else {
            if root?.right != nil {
                nodeString.append("(")
                nodeString.append(")")
            }
            preorder(root?.left)
        }
        if root?.right != nil {
            nodeString.append("(")
            preorder(root?.right)
            nodeString.append(")")
        } else {
            preorder(root?.right)
        }
    }
    
    ///中序遍历
    var array = [Int]()
    var result = [Int: Int]()
    func inorder(_ root: TreeNode?) {
        if root == nil {
            return
        }
        inorder(root?.left)
//        array.append(root!.val)
//        print("\(root!.val)")
        if let v = result[root!.val] {
            result[root!.val] = v + 1
        } else {
            result[root!.val] = 1
        }
        inorder(root?.right)
    }
    
    ///验证二叉搜索树
    func isValidBST(_ root: TreeNode?) -> Bool {
        return digui(root, nil, nil)
    }
    
    func digui(_ root: TreeNode?, _ lower: Int?, _ upper: Int?) -> Bool {
        if root == nil {
            return true
        }
        let v = root!.val
        if lower != nil, v >= lower! {
            return false
        }
        if upper != nil, v <= upper! {
            return false
        }
        if !digui(root?.left, v, upper) {
            return false
        }
        if !digui(root?.right, lower, v) {
            return false
        }
        return true
    }
    
    ///501. 二叉搜索树中的众数
    func findMode(_ root: TreeNode?) -> [Int] {
        inorder(root)
        let s = result.sorted { (r1, r2) -> Bool in
            return r1.value > r2.value
        }
        var r = [Int]()
        for item in s {
            if item.value == s.first?.value {
                r.append(item.key)
            }
        }
        return r
    }
    
//preorder = [3, 9, 8, 5, 4, 10, 20, 15, 7]
//inorder = [4, 5, 8, 10, 9, 3, 15, 20, 7]
    ///105. 从前序与中序遍历序列构造二叉树
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.isEmpty {
            return nil
        }
        let stack = Stack<TreeNode>()
        let root = TreeNode(preorder[0])
        stack.push(root)
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stack.top()
            if node?.val != inorder[inorderIndex] {
                node?.left = TreeNode(preorderVal)
                stack.push(node?.left)
            } else {
                while stack.size != 0 && stack.top()?.val == inorder[inorderIndex] {
                    node = stack.pop()
                    inorderIndex += 1
                }
                node?.right = TreeNode(preorderVal)
                stack.push(node?.right)
            }
        }
        return root
    }
    
//    中序遍历 inorder = [9,3,15,20,7]
//    后序遍历 postorder = [9,15,7,20,3]
    ///106. 从中序与后序遍历序列构造二叉树
    var inorder = [Int]()
    var postorder = [Int]()
    var map = [Int: Int]()
    var postIndex = 0
    func buildTree2(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        self.inorder = inorder
        self.postorder = postorder
        self.postIndex = postorder.count - 1
        for i in 0..<inorder.count {
            map[inorder[i]] = i
        }
        return help(0, postIndex)
    }
    func help(_ left: Int, _ right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        let rootVal = postorder[postIndex]
        postIndex -= 1
        let root = TreeNode(rootVal)
        let rootIndex = map[rootVal]!
        root.right = help(rootIndex + 1, right)
        root.left = help(left, rootIndex - 1)
        return root
    }
    
    ///100. 相同的树
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }
        if p?.val != q?.val {
            return false
        }
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
    
    ///110. 平衡二叉树
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        return abs(heightBalanced(root?.left) - heightBalanced(root?.right)) < 2 && isBalanced(root?.left) && isBalanced(root?.right)
    }
    func heightBalanced(_ root: TreeNode?) -> Int {
        if root == nil {
            return -1
        }
        return 1 + max( heightBalanced(root?.left), heightBalanced(root?.right))
    }
    
    ///面试题07. 重建二叉树
    func buildTree3(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.isEmpty || inorder.isEmpty || preorder.count != inorder.count {
            return nil
        }
        let root = TreeNode(preorder.first!)
        if preorder.count == 1 && inorder.count == 1 {
            return root
        }
        let indexInorder = inorder.firstIndex(of: preorder.first!)!
        let leftInorder  = inorder[0..<indexInorder]
        let leftPreorder = preorder[1..<leftInorder.count+1]
        let rightInorder  = inorder[indexInorder+1..<inorder.count]
        let rightPreorder = preorder[leftInorder.count+1..<preorder.count]
        root.left  = buildTree3(Array(leftPreorder), Array(leftInorder))
        root.right = buildTree3(Array(rightPreorder), Array(rightInorder))
        return root
    }
}

//let solution2 = Solution2()
//let t = solution2.buildTree3([3,9,20,15,7], [9,3,15,20,7])
//print(t)


/**
 *  297. 二叉树的序列化与反序列化
 */
class Codec {
    
    func rserialize(_ root: TreeNode?, _ strs: String ) -> String {
        var strs = strs
        if root == nil {
            strs += "none,"
        } else {
            strs += String(root!.val)+","
            strs = rserialize(root?.left, strs)
            strs = rserialize(root?.right, strs)
        }
        return strs
    }
    
    func serialize(_ root: TreeNode?) -> String {
        return rserialize(root, "")
    }
    
    func rdeserialize(_ data: inout [Substring]) -> TreeNode? {
        if data.first! == "none" {
            data.remove(at: 0)
            return nil
        }
        let v = Int(String(data.remove(at: 0)))!
        let root  = TreeNode(v)
        root.left = rdeserialize(&data)
        root.right = rdeserialize(&data)
        return root
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        var strs = Array(data.split(separator: ","))
        return rdeserialize(&strs)
    }
    
    
}
