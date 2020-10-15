//
//  Shuffle.swift
//  LeetCodeTest
//
//  Created by WangZhenGang on 2020/9/22.
//  Copyright © 2020 王振钢. All rights reserved.
//

import Foundation


/**
 *  随机打乱一个数组
 */
class ShuffleArray {
    
    let origin: [Int]

    init(_ nums: [Int]) {
        self.origin = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        return self.origin
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        return self.origin.shuffled()
        
//        for i in 0..<origin.count {
//            origin.swapAt(i, Int.random(in: i..<origin.count))
//        }
    }
    
}
