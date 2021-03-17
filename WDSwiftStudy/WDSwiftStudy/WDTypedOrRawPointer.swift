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
        test()
        addClassToStruct()
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


//访问结构体实例对象
extension WDTypedOrRawPointer {
    struct WDTeacher {
        var age = 20
        var height = 1.88
    }
//    使用UnsafeMutablePointer创建指针，并通过指针访问WDTeacher实例对象，有以下三种方式：
//    方式一：下标访问
//    方式二：内存平移
//    方式三：successor
    func test() {
        //分配两个WDTeacher大小的空间
        let ptr = UnsafeMutablePointer<WDTeacher>.allocate(capacity: 2)
        // 初始化第一个空间
        ptr.initialize(to: WDTeacher())
        // 移动 初始化第二个空间
        ptr.successor().initialize(to: WDTeacher(age: 30, height: 1.75))
        // 访问方式1
        print("struct WDTeacher 1:",ptr[0])
        print("struct WDTeacher 1:",ptr[1])
        
        // 访问方式2
        print("struct WDTeacher 2: ptr.pointee",ptr.pointee)
        print("struct WDTeacher 2: ptr.pointee",ptr.successor().pointee)

        // 访问方式3
        print("struct WDTeacher 3:",ptr.pointee)
        print("struct WDTeacher 3:",(ptr+1).pointee)
        
//        需要注意的是，第二个空间的初始化不能通过advanced(by: MemoryLayout<CJLTeacher>.stride)去访问，否则取出结果是有问题
//        可以通过ptr + 1或者successor() 或者advanced(by: 1)
//        <!--第2个初始化 方式一-->
        (ptr + 1).initialize(to: WDTeacher(age: 21, height: 1.75))
        print("struct WDTeacher 4:",ptr.pointee)
        print("struct WDTeacher 4:",(ptr+1).pointee)
        
//        <!--第2个初始化 方式二-->
        ptr.successor().initialize(to: WDTeacher(age: 22, height: 1.75))
        print("struct WDTeacher 5:",ptr.pointee)
        print("struct WDTeacher 5:",(ptr+1).pointee)
//        <!--第2个初始化 方式三-->
        ptr.advanced(by: 1).initialize(to:  WDTeacher(age: 23, height: 1.75))
        print("struct WDTeacher 6:",ptr.pointee)
        print("struct WDTeacher 6:",(ptr+1).pointee)
        
//        这里的ptr如果使用advanced(by: MemoryLayout<WDTeacher>.stride)即16*16字节大小，此时获取的结果是有问题的，由于这里知道具体的类型，所以只需要标识指针前进 几步即可，即advanced(by: 1)

    }
}

struct HeapObject {
//    var kind : Int
    var kind : UnsafeRawPointer
    var strongRef: UInt32
    var unownedRef: UInt32
}
class WDTeacherClass: NSObject {
    var age_1 = 18
    
}
extension WDTypedOrRawPointer {
//    类的实例对象如何绑定到 结构体内存中？
//
//    1、获取实例变量的内存地址
//    2、绑定到结构体内存,返回值是UnsafeMutablePointer<T>
//    3、访问成员变量 pointee.kind
    func addClassToStruct()  {
        var t = WDTeacherClass()
        //将t绑定到结构体内存中
        //1、获取实例变量的内存地址，声明成了非托管对象
        /*
         通过Unmanaged指定内存管理，类似于OC与CF的交互方式（所有权的转换 __bridge）
         - passUnretained 不增加引用计数，即不需要获取所有权
         - passRetained 增加引用计数，即需要获取所有权
         - toOpaque 不透明的指针
         */

        let ptr = Unmanaged.passUnretained(t as AnyObject).toOpaque()
        //2、绑定到结构体内存,返回值是UnsafeMutablePointer<T>
        /*
         - bindMemory 更改当前 UnsafeMutableRawPointer 的指针类型，绑定到具体的类型值
            - 如果没有绑定，则绑定
            - 如果已经绑定，则重定向到 HeapObject类型上
         */
        let heapObject = ptr.bindMemory(to: HeapObject.self, capacity: 1)
        //3、访问成员变量
        print("addClassToStruct heapObject.pointee.kind ",heapObject.pointee.kind)
        print("addClassToStruct heapObject.pointee.strongRef ",heapObject.pointee.strongRef)
        print("addClassToStruct heapObject.pointee.unownedRef ",heapObject.pointee.unownedRef)
    }
    
//    create\copy 需要使用retain
//
//    不需要获取所有权 使用unretain
//
//    将kind的类型改成UnsafeRawPointer，kind的输出就是地址了
    
}
