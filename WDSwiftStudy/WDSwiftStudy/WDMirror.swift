//
//  WDMirror.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/18.
//

import Foundation
import UIKit
//反射Mirror & 错误处理
//Mirror的使用以及使用Mirror进行JSON解析的错误处理
class WDMirror: NSObject {
    
    func wdMirrorDemo() {
        print("================== WDMirror")
        wdMirrorTest1()
        
        let teacher = WDMirrorTeacher()
        let json = jsonTest(teacher)
        print("WDMirror jsonTest",json)
        
        
        print("================== WDMirror wdMirrorJosnMapTest")
        wdMirrorJosnMapTest()
    }
    
}

class WDMirrorTeacher: NSObject {
    var age:Int = 18
    var name:String = "jwd"
    
}

// MARK: - Mirror初始化方法
//public init(reflecting subject: Any)
//进入Mirror初始化方法，发现传入的类型是Any，则可以直接传t
extension WDMirror {
    func wdMirrorTest1() {
        //        let mirror = Mirror(reflecting: WDMirrorTeacher.self)运行此代码，发现没有任何打印，为什么？是因为Mirror中传入的参数不对，应该是传入实例对象，修改如下
        let t = WDMirrorTeacher()
        let mirror = Mirror(reflecting: t)
        //public init(reflecting subject: Any)
        //进入Mirror初始化方法，发现传入的类型是Any，则可以直接传t
        for pro in mirror.children {
            print("WDMirror wdMirrorTest1  \(String(describing: pro.label)):\(pro.value)")
        }
    }
}

//public let children: Mirror.Children
//👇
////进入Children，发现是一个AnyCollection，接收一个泛型
//public typealias Children = AnyCollection<Mirror.Child>
//👇
////进入Child，发现是一个元组类型，由可选的标签和值构成，
//public typealias Child = (label: String?, value: Any)

//这也是为什么能够通过label、value打印的原因。即可以在编译时期且不用知道任何类型信息情况下，在Child的值上用Mirror去遍历整个对象的层级视图


// MARK: - json解析
extension WDMirror {
    func jsonTest(_ objc:Any) -> Any {
        let mirror = Mirror(reflecting: objc)
        // 判空
        guard !mirror.children.isEmpty else {
            return objc
        }
        // 字段
        var keyValue:[String:Any] = [:]
        for children in mirror.children {
            if let keyName = children.label {
                // 递归调用
                keyValue[keyName] = jsonTest(children.value)
            }else {
                print("children.label nil")
            }
        }
        return keyValue
    }
}




class WDMirrorJosnMapTeacher: WDMirrorJosnMap {
    var name = "WDMirrorJosnMap"
    var age = 99
    var height = 1.88
}
extension WDMirror {
    func wdMirrorJosnMapTest() {
        let te = WDMirrorJosnMapTeacher()
        let json_te = try? te.jsonMap()
//        Errors thrown from here are not handled 解决 添加？
        print("WDMirror wdMirrorJosnMapTest json:",json_te ?? nil)
        
        
        //通过do-catch来处理JSON解析的错误
        let assd = WDMirrorJosnMapTeacher()
        do {
            let json = try assd.jsonMap();
            print("WDMirrorJosnMapTeacher json:",json)
        }catch {
            print("WDMirrorJosnMapTeacher nil")
        }
        
    }
}
