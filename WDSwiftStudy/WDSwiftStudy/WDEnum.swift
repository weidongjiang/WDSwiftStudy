//
//  WDEnum.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/19.
//
//https://www.jianshu.com/p/127c538eb236
import Foundation

// MARK: - C语言中的枚举
/*
 
 enum Weak {
     MON,TUE,WED,THU,FRI,SAT,SUN
 }
 
 // 如果没有设置枚举默认值，一般第一个枚举成员的默认值是 整形0后面依次递推
 enum Weak {
     MON = 1,TUE,WED,THU,FRI,SAT,SUN
 }
 
 
 enum Weak {
     MON = 1,TUE,WED,THU,FRI,SAT,SUN
 }weak;
 
 enum {
     MON = 1,TUE,WED,THU,FRI,SAT,SUN
 }weak;
 
*/


// MARK: - Swift 中的枚举
class WDEnum: NSObject {
    enum Weak {
        case MON
        case TUE
        case WED
        case THU
        case FRI
        case SAT
        case SUN
    }
    
    enum Weak_1 {
        case MON,TUE,WED,THU,FRI,SAT,SUN
    }
    
    func wdEnumTest() {
        print("==================== WDEnum")
        enumTest_1()
        enumTest_2()
        enumTest_init()
        printEnum()
    }
    
    func enumTest_1() {
        let w: Weak = .MON
        print("WDEnum enumTest 1 :\(w)")
    }
    
    /// =左边的值是枚举值，
    /// =右边的值在swift中称为RawValue（原始值）
    /// 两者的关系为：case 枚举值 = rawValue
    enum Weak_2: String {
        case MON = "MON"
        case TUE = "TUE"
        case WED = "WED"
        case THU = "THU"
        case FRI = "FRI"
        case SAT = "SAT"
        case SUN = "SUN"
    }
    
    
    /// 如果不想写枚举值后的字符串，也可以使用隐式RawValue分配，如下所示
    enum Weak_3: String {
        case MON,TUE,WED = "wed",THU,FRI,SAT,SUN
    }
    enum Weak_4: Int {
        case MON,TUE,WED = 10,THU,FRI,SAT,SUN
    }
    
    /*
    这里就有一个疑问，swift是如何做到打印 MON的？我们通过SIL文件分析

    首先查看SIL文件中的enum，底层多增加了一些东西
    1、给枚举值的类型，通过typealias取了一个别名RawValue

    2、默认添加了一个可选类型的init方法

    3、增加一个计算属性rawValue，用于获取枚举值的原始值
     */
    func enumTest_2() {
        print("WDEnum enumTest 2 :",Weak_3.MON)//WDEnum enumTest 2 : MON
        print("WDEnum enumTest 2 rawValue:",Weak_3.MON.rawValue)// WDEnum enumTest 2 rawValue: MON

        /*
        虽然这两个输出的值从结果来看是没有什么区别的，虽然输出的都是MON，但并不是同一个东西

        第一个输出的case枚举值

        第二个是通过rawValue访问的rawValue的get方法
         */
    }
    
    
    
//    enum中init方法的调用是通过枚举.init(rawValue:）或者枚举(rawValue:）触发的
    func enumTest_init()  {
        print("WDEnum enumTest_init MON ",Weak_3.init(rawValue: "MON") ?? nil)
        print("WDEnum enumTest_init KK ",Weak_3.init(rawValue: "KK") ?? nil)

    }
   
    /*
    从结果中可以看出，第一个输出的可选值，第二个输出的是nil，表示没有找到对应的case枚举值。为什么会出现这样的情况呢？

    首先分析SIL文件中的weak.init方法，主要有以下几步：
    1、在init方法中是将所有enum的字符串从Mach-O文件中取出，依次放入数组中

    2、放完后，然后调用_findStringSwitchCase方法进行匹配
     
     - `struct_extract` 表示`取出当前的Int值`，Int类型在系统中也是结构体
     - `cond_br` 表示比较的表达式，即分支条件跳转
         - 如果匹配成功，则构建一个`.some的Optional`返回
         - 如果匹配不成功，则继续匹配，知道最后还是没有匹配上，则构建一个`.none的Optional`返回
     
     在swift-source中查找_findStringSwitchCase方法，接收两个参数，分别是 数组 + 需要匹配的String
     1、遍历数组，如果匹配则返回对应的index
     2、如果不匹配，则返回-1

     继续分析SIL中的weak.init方法
     1、如果没有匹配成功，则构建一个.none类型的Optional，表示nil
     2、如果匹配成功，则构建一个.some类型的Optional，表示有值
     
     */
}
public enum Weak_5: String {
    case MON,TUE,WED,THU,FRI,SAT,SUN
}
extension Weak_5: CaseIterable{}

// MARK: -  枚举的遍历
extension WDEnum {
    func printEnum() {
        let AllCases = Weak_5.allCases
        // for 循环遍历
        for en in AllCases {
            print("WDEnum printEnum AllCases:\(en)")
        }
        
        print("------------")
        // 函数式遍历
        let allCases = Weak_5.allCases.map({"\($0)"}).joined(separator: ",")
        print("WDEnum printEnum AllCases -1 :\(allCases)")
        
//        WDEnum printEnum AllCases:MON
//        WDEnum printEnum AllCases:TUE
//        WDEnum printEnum AllCases:WED
//        WDEnum printEnum AllCases:THU
//        WDEnum printEnum AllCases:FRI
//        WDEnum printEnum AllCases:SAT
//        WDEnum printEnum AllCases:SUN
//        ------------
//        WDEnum printEnum AllCases -1 :MON,TUE,WED,THU,FRI,SAT,SUN

    }
    
}
