//
//  WDEnumMemers.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/4/23.
//

import Foundation

func testEnum() {
    
//    enum TestEnum {
//        case test1, test2, test3
//    }
    
//    enum TestEnum {
//        case test1(Int,Int,Int)
//        case test2(Int,Int)
//        case test3(Int)
//        case test4(Bool)
//        case test5
//    }
    
    enum TestEnum {
        case test1(Int)
    }
    print(MemoryLayout<TestEnum>.size) //8
    print(MemoryLayout<TestEnum>.stride)// 8
    print(MemoryLayout<TestEnum>.alignment) //8

    
    
}
