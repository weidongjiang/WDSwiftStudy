//
//  main.swift
//  SwiftUnderstratum
//
//  Created by 蒋伟东 on 2022/5/2.
//

import Foundation



extension Int : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = value ? 1 : 0;
    }
}

var num: Int = true


var age = 10
var isRed = false
var name = "Jack"



var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
ptr.assumingMemoryBound(to: Int.self)

unsafeBitCast(ptr, to: UnsafeMutablePointer<Int>.self)


var array = NSArray(objects: 1, 2, 3, 4)
for item in array.enumerated() {
    print(item)
}
for (idx,ele) in array.enumerated() {
    print("enumerated",idx,ele)
}

array.enumerateObjects { ele, idx, stop in
    print("enumerateObjects",idx,ele)
    stop.pointee = true
}

//class kk {
//    private class Person {}
//    fileprivate class Student : Person {}
//}
//
//private class Person {}
//fileprivate class Student : Person {}






//var str1 = "0123456789ABCDEF"
//print(Mems.memStr(ofVal: &str1))
//
//var str2 = str1.appending("G")
//
//print(Mems.memStr(ofVal: &str2))
//
//print("1")

func isOdd<T: BinaryInteger>(_ i:  T) -> Bool {
    i % 2 != 0
}

extension BinaryInteger {
    func isOdd() -> Bool { self % 2 != 0}
}

struct Po {
    var x: Int = 0
    var y: Int = 0
}
extension Po {
    init(_ po: Po) {
        self.init(x: po.x, y:po.y)
    }
}


//class Per : CustomDebugStringConvertible{
//    var age: Int
//    var name: String
//    init(age: Int, name: String) {
//        self.age = age
//        self.name = name
//    }
//}

//extension Per : Equatable {
//    static func == (left: Per, right: Per) -> Bool {
//        left.age == right.age && left.name == right.name
//    }
//    convenience init() {
//        self.init(age: 0, name: "")
//    }
//}



extension Int {
    func repeats(task:()) -> Void {
        for _ in 0..<self {
            task
        }
    }
    
    mutating func square() -> Int {
        self = self * self
        return self
    }
    
    enum Kind {
        case negative, zero, positive
    }
    
    var kind : Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
    // 获取正数的每一个位上的值
    subscript(digitIndex: Int) -> Int {
        if digitIndex < 0 {
            return 0
        }
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

var age = 1234
print(age[-3])



extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex ..< endIndex).contains(idx) {
            return self[idx]
        }
        return nil
    }
}

class Car : Equatable {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    static func == (lhs:Car ,rhs:Car) -> Bool {
        lhs.age == rhs.age
    }
}

var c1 = Car(age: 10)
var c2 = Car(age: 10)

print(c1 == c2)
print(c1 != c2)


struct Person : Equatable {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    
}

var p1 = Person(age: 10)
var p2 = Person(age: 10)

print(p1 == p2)
print(p1 != p2)


var arr = [1,2,3,4]
print(MemoryLayout.stride(ofValue: arr))
print(Mems.memStr(ofVal: &arr))

struct Point {
    var x = 0, y = 0
    static func + (v1: Point, v2: Point) -> Point {
        Point(x: v1.x + v2.x, y: v1.y + v2.y)
    }
    
    static func - (v1: Point, v2: Point) -> Point {
        Point(x: v1.x - v2.x, y: v1.y - v2.y)
    }
    static prefix func - (p: Point) -> Point {
        Point(x: -p.x, y: -p.y)
    }
    
    static func += (v1: inout Point, v2: Point) {
        v1 = v1 + v2
    }
    
    static prefix func ++ (v1: inout Point) -> Point {
        v1 += Point(x: 1, y: 1)
        return v1
    }
    
    static postfix func ++ (v1: inout Point) -> Point {
        let p = v1
        v1 += Point(x: 1, y: 1)
        return p
    }
}



var v1 = Point(x: 10, y: 10)
var v2 = Point(x: 11, y: 22)

var v3 = v1 + v2
print(v3)
