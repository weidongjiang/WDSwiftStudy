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
        print("WDPerson",p)
        
        let s = WDStudent(name: "kk")
        let s1 = WDStudent(age: 90)
        
        print("WDStudent s",s.name,s.s_age)
        print("WDStudent s1",s1.name,s1.s_age)
        
        
    }
    
    
}
