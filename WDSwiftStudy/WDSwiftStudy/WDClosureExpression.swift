//
//  WDClosureExpression.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/4/24.
//

import Foundation

class WDClosureExpression : NSObject {
    
    var fn = {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    }
    //
//    {
//        (v1: Int, v2: Int) -> Int in
//        return v1 + v2
//    }(10,20)
    
    func exec(v1:Int, v2:Int, fn:(Int,Int) -> Int) {
        print(fn(v1,v2))
    }
    
//    exec(v1:Int,v2:Int, fn:{
//        (v1,v2) in return v1 + v2
//    })
    
    typealias Fn = (Int) -> Int
    
    func getFn() -> Fn {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        
        return plus
    }
    
    
    var height : Double {
        willSet {
           print("willset",newValue)
        }
        didSet {
            print("didset",oldValue)
        }
    }

}
public class FileManager {
    public static let shard = FileManager()
    private init() {
        
    }
    
}
