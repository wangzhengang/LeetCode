//
//  HashMap.swift
//  LeetCodeTest
//
//  Created by 王振钢 on 2020/3/31.
//  Copyright © 2020 王振钢. All rights reserved.
//

import Foundation



public struct HashMap<Key: Hashable, Value> {
    typealias Element = (key: Key, value: Value)
    var arraySize: Int
    var numberInserted = 0
    var array: [Element?]
    var loadFactor: Double {
        return Double(numberInserted) / Double(arraySize)
    }
    
    public init(size: Int = 11) {
        self.arraySize = size
        array = [Element?](repeating: nil, count: size)
    }
    
    private mutating func checkLoad() {
        if loadFactor >= 0.75 {
            print("\n---")
            print("\nNew array time!\n")
            print("---\n")
            numberInserted = 0
            
            let buffer = array.compactMap { $0 } //array.flatMap { $0 }
            print(buffer, terminator: "\n\n")
            arraySize *= 2
            array = [Element?](repeating: nil, count: arraySize)
            
            for i in buffer {
                add(key: i.key, value: i.value)
            }
        }
    }
    
    private func hash(of item: Key) -> Int {
        return item.hashValue % arraySize
    }
    
    private func probe(for item: Key) -> Int {
        return ((arraySize ^ item.hashValue) % arraySize) + 1
    }
    
    public mutating func add(key: Key, value: Value) {
        let hashVal = self.hash(of: key)
        let probeVal = self.probe(for: key)
        
        print("Hash = \(hashVal)")
        print("Probe = \(probeVal)")
        
        var fullIndex = hashVal
        
        var inserted = false
        
        while !inserted {
            if array[fullIndex] != nil {
                if key == array[fullIndex]?.key {
                    array[fullIndex] = (key, value)
                    checkLoad()
                    inserted = true
                }
                
                print("array[\(fullIndex)] in use by \(array[fullIndex]). Trying again.")
                fullIndex += probeVal
                print("fullIndex value now \(fullIndex)")
                
                if fullIndex >= arraySize {
                    fullIndex -= arraySize
                    print("fullIndex out of range. Subtracting \(arraySize). Value now \(fullIndex)")
                }
            } else {
                array[fullIndex] = (key, value)
                print("Successfully inserted \(value) at array[\(fullIndex)]")
                numberInserted += 1
                print("\nNumber inserted: \(numberInserted)\n")
                inserted = true
                checkLoad()
            }
        }
        
        print("---")
    }
    
    public func get(_ key: Key) -> Value? {
        let hash = self.hash(of: key)
        let probe = self.probe(for: key)
        
        var fullIndex = hash
        var found = false
        
        while !found {
            if array[fullIndex] != nil {
                if array[fullIndex]?.key == key {
                    found = true
                    return array[fullIndex]?.value
                } else {
                    fullIndex += probe
                    if fullIndex >= arraySize {
                        fullIndex -= arraySize
                    }
                }
            } else {
                return nil
            }
        }
    }
    
    public func containsValue(for key: Key) -> Bool {
        let hash = self.hash(of: key)
        let probe = self.probe(for: key)
        
        var fullIndex = hash
        var found = false
        
        guard array[fullIndex] != nil else { return false }
        
        while !found {
            if array[fullIndex]?.key == key {
                found = true
                return true
            } else {
                fullIndex += probe
                if fullIndex >= arraySize {
                    fullIndex -= arraySize
                }
            }
        }
    }
    
    public mutating func removeValue(for key: Key) {
        let hash = self.hash(of: key)
        let probe = self.probe(for: key)
        
        var fullIndex = hash
        var found = false
        
        while !found {
            if array[fullIndex]?.key == key {
                array[fullIndex] = nil
                numberInserted -= 1
                found = true
            } else {
                fullIndex += probe
                if fullIndex >= arraySize {
                    fullIndex -= arraySize
                }
            }
        }
    }
}

// MARK: - Subscript functionality
extension HashMap {
    public subscript(key: Key) -> Value? {
        get {
            return get(key)
        }
        
        set {
            guard let value = newValue else { return }
            add(key: key, value: value)
        }
    }
}

//// MARK: - Collection
//extension HashMap: Collection {
//
//}
// MARK: - CustomStringConvertible
extension HashMap: CustomStringConvertible {
    public var description: String {
        var stringToReturn = "[\n"
        
        for (index, value) in array.enumerated() {
            if let item = value {
                stringToReturn.append("    ")
                stringToReturn.append(String(describing: item.key))
                stringToReturn.append(": ")
                stringToReturn.append(String(describing: item.value))
                if index != arraySize - 1 {
                    stringToReturn.append(",")
                }
            } else {
                stringToReturn.append("    ")
                stringToReturn.append("-")
            }
            stringToReturn.append("\n")
        }
        stringToReturn.append("]")
        
        return stringToReturn
    }
}
