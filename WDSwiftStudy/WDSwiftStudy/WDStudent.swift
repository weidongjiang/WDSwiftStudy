//
//  WDStudent.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/5.
//

import UIKit


class WDStudent: WDPerson {
    var s_age :Int
    
    init(age:Int) {
        s_age = age
        super.init()
    }
    
    override init(name: String) {
        self.s_age = 0
        super.init(name: name)
    }
    
}
