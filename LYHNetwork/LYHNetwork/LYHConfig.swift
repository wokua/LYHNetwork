//
//  LYHConfig
//  TFM
//
//  Created by lrk on 2018/10/24.
//  Copyright © 2018年 KF. All rights reserved.
//

import Foundation

open class LYHConfig {
    
    static let share = LYHConfig()
    /// 默认baseURL
    var baseUrl = "http://v.juhe.cn/"
    
    //默认超时时间
    var timeOut: TimeInterval = 15
    
    //默认参数
    func generalParament() -> [String : Any] {
        return ["key":"e6522dba527b0633ac079f2e217b1d5e"];
    }
    
    //默认请求头
    func generalHeader() -> [String : String] {
        return [:]
    }
    
    //默认结果解析字段
    func generalResponse() -> [String] {
        return ["result","data"]
    }
    
    //默认code解析字段
    func codeResponse() -> [String] {
        return ["error_code"]
    }
    
    //默认错误消息解析字段
    func messageResponse() -> [String] {
        return ["reason"]
    }
}
