//
//  Item.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/10.
//

import Foundation
import KakaJSON
import HandyJSON
class User : Convertible ,HandyJSON{
    
    required init() {
        
    }
}

class Comment : Convertible ,HandyJSON{
    
    required init() {
        
    }
}

class Item : Convertible ,HandyJSON{
    let content: String = ""
    let commentsCount: Int = 0
    let lowUrl: String = ""
    let highUrl: String = ""
    let originUrl: String = ""
    let publishedAt: Int = 0
    let user: User! = nil
    let hotComment: Comment? = nil
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name.kj.underlineCased()
    }
    required init() {
        
    }
}
