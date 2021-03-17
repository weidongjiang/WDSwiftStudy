//
//  WDDemo.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/5.
//

import UIKit


class WDDemo: NSObject {
    
    func wdDemo1() {
        let p = WDPerson()
        print("WDPerson",p.height)
        
        let s = WDStudent(name: "kk")
        let s1 = WDStudent(age: 90)
        s.ower = "s"
//        s1.ower = "s1"
        print("WDStudent s",s.name,s.s_age,s.height,s.ower ?? "default value")
        print("WDStudent s1",s1.name,s1.s_age,s1.height,s1.ower ?? "s1 default value")
        
        
    }
    
    deinit {// 当该类即将被销毁是调用此方法
        
    }
    
    
    enum Suit {
        case spades,hearts,diamods,clubs
        
        func simpleDescription() -> String {
            switch self {
            case .spades:
                return "spades"
            case .hearts:
                return "hearts"
            case .diamods:
                return "diamods"
            case .clubs:
                return "clubs"
            }
        }
    }
    let heart = Suit.spades
//    let description = heart.simpleDescription()
    
}



// 单利
public class WDShareinstace:NSObject {
    var name:String
    public static let shareInstace = WDShareinstace()
    private override init() {
        self.name = "kk"
        super.init()
    }
}


public protocol optionalType {
    associatedtype Wrapped
    var value:Wrapped?{get}
    
}


extension WDDemo {
    func addExtensionFunc(age:Int) -> Int {
        return age + 10
    }
}
