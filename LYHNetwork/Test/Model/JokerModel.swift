//
//  JokerModel.swift
//  LYHNetwork
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import Foundation
import ObjectMapper

class JokeModel : Mappable{
    var content : String = "";
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        content <- map["content"]
    }
    
}
