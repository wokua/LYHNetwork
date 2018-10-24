//
//  Config.swift
//  LYHNetworkDemo
//
//  Created by lrk on 2018/10/17.
//  Copyright © 2018年 sku. All rights reserved.
//

import Foundation

open class LYHConfig {
    
    static let share = LYHConfig()
    /// 默认baseURL
    var baseUrl = ""
    
    //默认超时时间
    var timeOut: TimeInterval = 5
    
    //默认参数
    func generalParament() -> [String : Any] {
        return [:]
    }
    
    //默认请求头
    func generalHeader() -> [String : String] {
        return [:]
    }
    
    //默认结果解析字段
    func generalResponse() -> [String] {
        return ["result","data"]
    }
}
