//
//  WDOptional.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/4/22.
//

import Foundation

var array = [1,2,3,4]
func getaRrray(_ index: Int) -> Int? {
    if index < 0 || index >= array.count {
        return nil
    }
    return array[index]
}

func test() {
    
    var age: Int? = 10
    var b = age! + 20
    
    let number = Int("123")
    if number != nil {
        print("字符串转换整数成功：\(number!)")
    }else {
        print("字符串转换整数error")
    }
    
    // 可选项绑定
    if let height = Int("123") {
        print("字符串转换整数成功：\(height)")
    }else {
        print("字符串转换整数error")
    }
    
//    if let first = Int("4") {
//        if let second = Int("33") {
//            if let first < second && second < 100 {
//                print("\(first) < \(second) < 100")
//            }
//        }
//    }
//
//    if let fi rst = Int("4"), let second = Int("33"),let first < second && second < 100 {
//        print("\(first) < \(second) < 100")
//    }
    
//    let a: Int? = nil
//    let b: Int? = 1
//
//    if let c = a, let d = b {
//
//    }
//    // 类似于
//    if a != nil && b != nil
//
//
//    if let c = a ?? b {
//        print(c)
//    }
//    /// 类似于
//    var c: Int?
//    if a != nil || b != nil {
//        if a != nil {
//            c = a
//        }
//        if b != nil {
//            c = b
//        }
//    }
// 
//    let num1: Int! = 10
//    let num2: Int = num1
//
    
}

