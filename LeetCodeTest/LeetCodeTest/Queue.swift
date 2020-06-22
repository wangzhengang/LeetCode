//
//  Queue.swift
//  LeetCodeTest
//
//  Created by 王振钢 on 2020/5/12.
//  Copyright © 2020 王振钢. All rights reserved.
//

import Foundation


/**
 *  队列
 */
class Queue<T> {
    
    var size = 0
    var q = [T]()
    
    func enqueue(_ e: T? ) {
        if e != nil {
            q.append(e!)
            size += 1
        }
    }
    
    @discardableResult
    func dequeue() -> T? {
        if size > 0 {
            size -= 1
            return q.remove(at: 0)
        }
        return nil
    }
    
    func front() -> T? {
        return q.first
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func clear() {
        size = 0
        q.removeAll()
    }
}



/**
 * 两个栈实现一个队列
 */
class CQueue {
    
    var tailStack = Stack<Int>()
    var headStack = Stack<Int>()
    
    init() {
        
    }
    
    func appendTail(_ value: Int) {
        while !headStack.isEmpty() {
            let top = headStack.pop()!
            tailStack.push(top)
        }
        tailStack.push(value)
    }
    
    func deleteHead() -> Int {
        while !tailStack.isEmpty() {
            let top = tailStack.pop()!
            headStack.push(top)
        }
        if !headStack.isEmpty() {
            return headStack.pop()!
        } else {
            return -1
        }
    }
    
}
