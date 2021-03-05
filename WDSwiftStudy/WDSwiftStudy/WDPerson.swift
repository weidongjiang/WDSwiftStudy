//
//  WDPerson.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/5.
//

/*
 //重载: 函数名相同,函数的参数类型或者参数的个数不同,函数就形成了重载,任何函数都可以重载
 
    * 是面向对象的重要特征之一
    * 可以简化程序员的记忆
    * 根据不同的参数实现不同的需求
    *   ***构造函数的重载有特殊之处***
        - 如果构造函数发生了重载,子类中所有 没有被重写的构造函数都不能够被访问
        - 原因: 不能够保证子类的必选属性一定有值
 */

import UIKit

class WDPerson: NSObject {
    var name : String
    
    override init() {
        name = "jwd"
        super.init()
    }
    
    init(name:String) {
        self.name = name
        super.init()
    }
    
    
}
