//
//  WDAsync.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/6.
//

import Foundation
import UIKit

public typealias Task = () -> Void

// MARK: - 异步执行
public struct WDAsync {
    
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    
    public static func async(_ task: @escaping Task, _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    
    private static func _async(_ task: @escaping Task, _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    // MARK: - 延迟
    @discardableResult
    public static func delay(_ seconds: Double, _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        return item
    }
    
    // MARK: - 异步延迟
    @discardableResult
    public static func asyncDelay(_ seconds: Double, _ task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }

    public static func asyncDelay(_ seconds: Double, _ task: @escaping Task, _ mainTask: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }

    private static func _asyncDelay(_ seconds: Double,_ task: @escaping Task, _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
    
}



let shardManager: Void = {
    // 初始化一次的
    
}()

class viewController: UIViewController {
    static let shardManager: Void = {
        // 初始化一次的
        
    }()
}
