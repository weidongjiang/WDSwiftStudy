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
    
   // setter
    var ower:String? {
        didSet {
            print("didSet",oldValue ?? "default value",ower ?? "default")
        }
        willSet {
            print("willSet",ower ?? "default")
        }
    }
    
    
    // 懒加载
    lazy var label = UILabel()
    lazy var button = UIButton()
    lazy var ageLabel:UILabel = {
        let l = UILabel()
        l.text = "jhdl"
        return l
    }()
    
}
