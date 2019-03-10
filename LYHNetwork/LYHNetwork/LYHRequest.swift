//
//  LYHRequest
//  TFM
//
//  Created by lrk on 2018/10/24.
//  Copyright © 2018年 KF. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum LYHHTTPMethod : String{
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
    var httpMethod:HTTPMethod{
        return HTTPMethod.init(rawValue: self.rawValue) ?? .get
    }
}

// 定义失败的闭包
typealias FailureHandler = (_ error: LYHNetworkError) -> Void

/// 文件
struct File {
    var data: Data
    var fileName: String
    var mimeType: String
}

class LYHRequest<T:Any> {
    
    fileprivate lazy var subject = LYHRequestSubject<T>()
    
    var agent : LYHAgent<T>?
    
    // 定义成功的闭包
    var success: ((_ value:T) -> Void)?
    
    // 定义失败的闭包
    var failure: FailureHandler?
    
    var param = [String : Any]() //请求参数
    
    
    init(){
        
    }
    
    //接口基础地址，如果不设置，返回默认的
    func baseUrl() -> String {
        return LYHConfig.share.baseUrl
    }
    
   //接口API
    func api() -> String {
        fatalError("未设置Api,请求必须重写api")
    }
    
    //网络请求方式  默认Post请求
    func method() -> LYHHTTPMethod {
        return .get
    }
    
    //请求超时，默认Config里面的
    func timeOut() -> TimeInterval {
        return LYHConfig.share.timeOut
    }
    
    //设置接口请求参数
    func addParameters(_ parameters : inout [String:Any]){
        
    }
    
    //设置文件信息
    func addFiles(_ parameters : inout [String:File]){
        
    }
}

extension LYHRequest{
    
    var manager : LYHRequestSubject<T> {
        get{
            subject.lyhrequest = self
            return subject
        }
    }
    
}
