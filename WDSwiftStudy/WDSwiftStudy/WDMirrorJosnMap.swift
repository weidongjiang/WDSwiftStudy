//
//  WDMirrorJosnMap.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/18.
//

import Foundation


protocol WDMirrorJosnMap {
    func jsonMap() -> Any
}
//【问题】：运行代码发现，并不是我们想要的结果,原因是因为CJLTeacher中属性的类型也需要遵守WDMirrorJosnMap协议
extension Int:WDMirrorJosnMap{}
extension String:WDMirrorJosnMap{}
extension Float:WDMirrorJosnMap{}
extension Double:WDMirrorJosnMap{}

extension WDMirrorJosnMap {
    func jsonMap() -> Any {
        let mirror = Mirror(reflecting: self)
        
        // 递归终止
        guard !mirror.children.isEmpty else {
            return self
        }
        
        // 字典 用于存储json数据
        var keyValue : [String:Any] = [:]
        for children in mirror.children {
            if let value = children.value as? WDMirrorJosnMap {
                if let keyName = children.label {
                    keyValue[keyName] = value.jsonMap()
                }else {
                    print("key is nil")
                }
            }else {
                print("没有遵守 WDMirrorJosnMap 协议")
            }
        }
        return keyValue
    }
}
