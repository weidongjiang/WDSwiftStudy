//
//  WDObserver.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/9.
//

import Foundation
import RxCocoa
import RxSwift

let observer = AnyObserver<Int>.init { event in
    switch event {
    case .next(let data):
        print(data)
    case .completed:
        print("completed")
    case .error(let error):
        print("error",error)
    }
}



struct WDObserver {
    
    
    static func creatobservable() {
        
        Observable.just(100).subscribe(observer).dispose()
        
        
        // 发送事件
    //        let observable = Observable<Int>.create { observer in
    //            observer.onNext(22)
    //            return Disposables.create()
    //        }
    //
    //
    //        let observable = Observable<Int>.just(2222)
        
//        let observable = Observable<Int>.timer(.seconds(2), period: .seconds(1), scheduler: MainScheduler.instance)
//
//        //监听事件
//        observable.subscribe { element in
//            print("element",element)
//        } onError: { error in
//            print("error",error)
//
//        } onCompleted: {
//            print("onCompleted")
//
//        } onDisposed: {
//            print("onDisposed")
//
//        }
    }
    
    
    func observableSubscribe(_ observable: Observable<Any>) {
        
    }
    

    
}
