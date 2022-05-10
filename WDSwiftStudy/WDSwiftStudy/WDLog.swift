//
//  WDLog.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/5.
//

import Foundation

func WDLog<T>(_ msg: T, file: NSString = #file, line: Int = #line, fn: String = #function) {
    #if DEBUG
    let prefix = "\(file.lastPathComponent) \(line) \(fn):"
    print(prefix,msg)
    #endif
}


