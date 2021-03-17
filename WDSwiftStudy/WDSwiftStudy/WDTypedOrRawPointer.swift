//
//  WDTypedOrRawPointer.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/17.
//

// 指针

import Foundation


class WDTypedOrRawPointer: NSObject {
    func wdTypedOrRawPointer() {
        rUnsafeMutableRawPointer()
        rUnsafeMutableRawPointer_1()
        _withUnsafePointer()
        changeValue()
    }
    
    func rUnsafeMutableRawPointer(){
        // 定义一个未知类型的指针：分配32字节大小的空间，指定对齐方式是8字节
        let p = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: 8)
        // 存储
        for i in 0..<4 {
            p.storeBytes(of: i + 1, as: Int.self)
        }
        // 读取
        for i in 0..<4 {
            let value = p.load(fromByteOffset: i * 8, as: Int.self)
            print("index:\(i),value:\(value)")
        }
        // 手动释放内存
        p.deallocate()
        
//        打印结果
//        index:0,value:4
//        index:1,value:-2305834216380291405
//        index:2,value:2
//        index:3,value:562949953421312
//        通过运行发现，在读取数据时有问题，原因是因为读取时指定了每次读取的大小，但是存储是直接在8字节的p中存储了i+1，即可以理解为并没有指定存储时的内存大小
    }
    
    
    func rUnsafeMutableRawPointer_1(){
        // 定义一个未知类型的指针：分配32字节大小的空间，指定对齐方式是8字节
        let p = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: 8)
        // 存储
        for i in 0..<4 {
            p.advanced(by: i * 8).storeBytes(of: i + 1, as: Int.self)//修改：通过advanced(by:)指定存储时的步长
        }
        // 读取
        for i in 0..<4 {
            let value = p.load(fromByteOffset: i * 8, as: Int.self)
            print("index:\(i),value:\(value)")
        }
        // 手动释放内存
        p.deallocate()
        
//        打印结果
//        index:0,value:1
//        index:1,value:2
//        index:2,value:3
//        index:3,value:4
    }
}


extension WDTypedOrRawPointer {
    // 获取基本数据类型的地址 方式
    func _withUnsafePointer()  {
        var age = 10
        //    <!--使用1-->
        let p = withUnsafePointer(to: &age) { $0 }
        print("_withUnsafePointer p",p)
        
        //    <!--使用2-->
        withUnsafePointer(to: &age){print("_withUnsafePointer $0",$0)}
        
        //    <!--使用3-->
        //其中p1的类型是 UnsafePointer<Int>
        let p1 = withUnsafePointer(to: &age) { ptr in
            return ptr
        }
        print("_withUnsafePointer p1",p1)//指针地址
        print("_withUnsafePointer p1 pointee",p1.pointee)// 指针对应的值
    }
    
    //改变变量值的方式有两种，一种是间接修改，一种是直接修改
    func changeValue()  {
        //间接方式
        var age = 11
        age = withUnsafePointer(to: &age, { ptr in
            return ptr.pointee + 11
        })
        print("changeValue age :",age)
        
        // 直接修改1
        withUnsafeMutablePointer(to: &age) { ptr in
            ptr.pointee += 100
        }
        print("changeValue age1 :",age)
        
        // 直接修改2
        // 分配容量大小 8字节
        let ptr = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        // 初始化
        ptr.initialize(to: age)
        ptr.deinitialize(count: 1)
        
        ptr.pointee = 1000 + ptr.pointee
        print("changeValue age2 :",ptr.pointee)
        // 销毁
        ptr.deallocate()
    }
}
