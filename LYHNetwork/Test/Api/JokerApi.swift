//
//  JokerApi.swift
//  LYHNetwork
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import Foundation

class JokerApi : LYHRequest<[JokeModel]>{//（返回数组写数组、单个写单个，空写()，字符串写String）
    
    override func method() -> LYHHTTPMethod { return .get }
    
    override func api() -> String { return "joke/content/list.php" }
    
    override func addParameters(_ parameters: inout [String : Any]) {
        parameters["sort"] = "asc"
        parameters["page"] = 1
        parameters["pagesize"] = 10
        parameters["time"] = "1418816972"
    }
    
}//
