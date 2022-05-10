//
//  WDQueue.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/7.
//

import Foundation


public struct queue {
    
    private static var queArray = Array<Any>()
    
    // 信号量
    private static var lock = DispatchSemaphore(value: 1)
    // 互斥锁
//    private static var lock = NSLock()

    // 递归锁
//    private static var lock = NSRecursiveLock()

    
    public static func addQueue(_ item: Any) {
        lock.wait()
        defer { lock.signal() }
        
        queArray.append(item)
    }
    
    public static func removeFistQueue() {
        
        lock.wait()
        defer { lock.signal() }
        
        queArray.remove(at: 0)
    }
}


