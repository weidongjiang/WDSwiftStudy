//
//  WDProtocol.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/8.
//

import Foundation


struct WD<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol WDCompatible {}
extension WDCompatible {
    var wd: WD<Self> {
        set {}
        get { WD(self) }
    }
    static var wd: WD<Self>.Type {
        set {}
        get { WD<Self>.self }
    }
}

extension String : WDCompatible {}
// 对 NSString NSMutableString 扩展
extension NSString: WDCompatible {}

extension WD where Base: ExpressibleByStringLiteral {
   var numberCount: Int {
        var count = 0
       for c in base as! String {
           if ("0"..."9").contains(c) {
               count += 1
           }
        }
        return count
    }
    
    static func test() {
        print("wdtest")
    }
}


//MARK:- 利用协议实现类型判断
/// 判断是否是一个数字类型
public func isArray(_ value: Any) -> Bool {
    value is [Any]
}

protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}
public func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}
