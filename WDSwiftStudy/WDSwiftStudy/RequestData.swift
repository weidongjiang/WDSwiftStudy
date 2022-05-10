//
//  RequestData.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/5/10.
//

import Foundation
import Alamofire
import HandyJSON
import KakaJSON

class URLAPI {
    let imgRank = "http://m2.qiushibaike.com/article/list/imgrank"
    func getDataimgRank(_ url: String) {
        
        AF.request(url,parameters: ["page":1]).responseData { response in
            
            guard let data = response.data else {return}
            
            let json = try? JSONSerialization
                .jsonObject(with: data, options: .mutableContainers) as? [String:Any]

            if let items = json?["items"] {
                
                for item in (items as! [[String:Any]]) {
                    let itemModel = Item.deserialize(from: item)
                    print(itemModel?.content as Any)
                }
            }
        }
    }
}


