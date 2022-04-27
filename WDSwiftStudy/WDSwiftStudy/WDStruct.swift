//
//  WDStruct.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/4/23.
//

import Foundation

func testStruct() {
    
    struct Point {
        var x: Int = 0
        var y: Int = 0
    }
    
    var p = Point()
    
    print(MemoryLayout<Point>.size) // 16
    print(MemoryLayout<Point>.stride)// 16
    print(MemoryLayout<Point>.alignment) //8

    
}

func testStruct1() {
    
    struct Point {
        var x: Int = 0
        var y: Int = 0
        var b: Bool = false
    }
    
    var p = Point()
    
    print(MemoryLayout<Point>.size) // 17
    print(MemoryLayout<Point>.stride)// 24
    print(MemoryLayout<Point>.alignment) //8

    
}

