//
//  Stack.swift
//  LeetCodeTest
//
//  Created by 王振钢 on 2020/5/12.
//  Copyright © 2020 王振钢. All rights reserved.
//

import Foundation


class Stack<T> {
    var size = 0
    var array = [T]()
    
    func push(_ e: T?) {
        if let v = e {
            array.append(v)
            size += 1
        }
    }
    
    @discardableResult
    func pop() -> T? {
        if size > 0 {
            size -= 1
            return array.removeLast()
        }
        return nil
    }
    
    func top() -> T? {
        return array[size-1]
    }
    
    func clear() {
        size = 0
        array.removeAll()
    }
    
    func isEmpty() -> Bool {
        return (size == 0)
    }
}


class MinStack {

    var main = Stack<Int>()
    var mins = Stack<Int>()
    
    init() {

    }
    
    func push(_ x: Int) {
        if main.isEmpty() {
            main.push(x)
            mins.push(x)
        } else {
            main.push(x)
            mins.push(min(mins.top()!, x))
        }
    }
    
    func pop() {
        main.pop()
        mins.pop()
    }
    
    func top() -> Int {
        return main.top()!
    }
    
    func getMin() -> Int {
        return mins.top()!
    }
}
