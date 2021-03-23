//
//  WDMirrorJosnMap.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/3/18.
//https://www.jianshu.com/p/8b9768e1e556

import Foundation

enum JSONMapError:Error {
    case emptyKey
    case noConformProtocol
}

extension JSONMapError: LocalizedError {
    var failureReason: String? {
        return "解析失败"
    }
    
    var recoverySuggestion: String? {
        return "建议检查 key 是否为空"
    }
    
    var helpAnchor: String? {
        return "help"
    }
    
    var errorDescription: String? {
        switch self {
        case .emptyKey:
            return "key为空"
        case .noConformProtocol:
            return "没有遵守协议"
        }
    }
}

extension JSONMapError: CustomNSError {
    static var errorDomain: String {
        return "errorDomain"
    }
    
    var errorCode: Int {
        switch self {
        case .emptyKey:
            return 404
        case .noConformProtocol:
            return 504
        }
    }
    
    var errorUserInfo: [String : Any] {
        return ["errorUserInfo":"errorInfo"]
    }
}

protocol WDMirrorJosnMap {
    func jsonMap() throws -> Any
}
//【问题】：运行代码发现，并不是我们想要的结果,原因是因为CJLTeacher中属性的类型也需要遵守WDMirrorJosnMap协议
extension Int:WDMirrorJosnMap{}
extension String:WDMirrorJosnMap{}
extension Float:WDMirrorJosnMap{}
//extension Double:WDMirrorJosnMap{}

extension WDMirrorJosnMap {
    func jsonMap() throws -> Any {
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
                    keyValue[keyName] = try value.jsonMap()
                }else {
                    print("key is nil")
                    throw JSONMapError.emptyKey // 区分是异常还是json
                }
            }else {
                print("没有遵守 WDMirrorJosnMap 协议")
                throw JSONMapError.noConformProtocol
            }
        }
        return keyValue
    }
}

// MARK: - 错误处理
// 错误处理
/*
为了让我们自己封装的JSON解析更好用，除了对正常返回的处理，还需要对其中的错误进行处理，在上面的封装中，我们目前采用的是print打印的，这样并不规范，也不好维护及管理。那么如何在swift中正确的表达错误呢？
public protocol Error {
}
Error是一个空协议，其中没有任何实现，这也就意味着你可以遵守该协议，然后自定义错误类型。所以不管是我们的struct、Class、enum，我们都可以遵循这个Error来表示一个错误

 //定义错误类型
 enum JSONMapError: Error{
     case emptyKey
     case notConformProtocol
 }
 
 但是这里有一个问题，jsonMap方法的返回值是Any，我们无法区分返回的是错误还是json数据，那么该如何区分呢？即如何抛出错误呢？在这里可以通过throw关键字（即将Demo中原本return的错误，改成throw抛出）

 使用时 用 try
 
 */



// MARK: - swift中错误处理的方式

/*
swift中错误处理的方式
swift中错误处理的方式主要有以下两种：

【方式一】：使用try关键字，是最简便的，即甩锅，将这个抛出给别人(向上抛出，抛给上层函数)。但是在使用时，需要注意以下两点：
try? 返回一个可选类型，只有两种结果：
要么成功，返回具体的字典值

要么错误，但并不关心是哪种错误，统一返回nil

try! 表示你对这段代码有绝对的自信，这行代码绝对不会发生错误
【方式二】：使用do...catch

*/


// MARK: - LocalError协议
//如果只是用Error还不足以表达更详尽的错误信息，可以使用LocalizedError协议，其定义如下
public protocol LocalizedError : Error {

    /// A localized message describing what error occurred.错误描述
    var errorDescription: String? { get }

    /// A localized message describing the reason for the failure.失败原因
    var failureReason: String? { get }

    /// A localized message describing how one might recover from the failure.建议
    var recoverySuggestion: String? { get }

    /// A localized message providing "help" text if the user requests help.帮助
    var helpAnchor: String? { get }
}


// MARK: - CustomNSError协议
//CustomNSError相当于OC中的NSError，其定义如下，有三个默认属性
public protocol CustomNSError : Error {

    /// The domain of the error.
    static var errorDomain: String { get }

    /// The error code within the given domain.
    var errorCode: Int { get }

    /// The user-info dictionary.
    var errorUserInfo: [String : Any] { get }
}

/*

总结
Error是swift中错误类型的基本协议，其中LocalizedError、CustomNSError都遵守Error

如果在方法中，想要同时返回正常值和错误，需要通过throw返回错误，并且在方法返回值的箭头前面加throws关键字，再调用方法时，还需要加上try关键字，或者使用do-catch，使用try时，有以下两点需要注意：

try? 返回的是一个可选类型，要么成功，返回正常值，要么失败，返回nil

try! 表示你对自己的代码非常自信，绝对不会发生错误，一旦发生错误，就会崩溃

使用建议：建议使用try?，而不是try!

 */
