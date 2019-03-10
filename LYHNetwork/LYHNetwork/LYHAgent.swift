//
//  LYHAgent
//  TFM
//
//  Created by lrk on 2018/10/24.
//  Copyright © 2018年 KF. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


// MARK: --- 单例设置代理 ---
class LYHAgent<T:Any> {
    // 记录请求，每次请求会添加到集合
    fileprivate var requestRecord: [String:LYHRequest<Any>] = [:]
    
//    static let share = LYHAgent()
    
    let manager: SessionManager
    
    init() {
        // 创建SessionManager
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = LYHConfig.share.timeOut
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
}

//创建请求
extension LYHAgent{
    
    func buildRequest(_ request:LYHRequest<T>) -> Alamofire.DataRequest{
        //接口请求地址
        let url : String
        if request.api().hasPrefix("http") {
             url = request.api()
        }else{
             url = request.baseUrl() + request.api()
        }
        //请求方式
        let method = request.method()
        //请求参数
        let parameters = buildParemeters(request)
        
        return buildRequest(method: method.httpMethod, url: url, parameters: parameters)
    }
    
    fileprivate func buildRequest(method: Alamofire.HTTPMethod,
                                  url: String,
                                  parameters: [String:Any]) -> Alamofire.DataRequest {
        // 这里 manager 不能用局部变量 （https://github.com/Alamofire/Alamofire/issues/157）
        var header = SessionManager.defaultHTTPHeaders
        addGeneralHeader(&header)
        let request = manager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
        print("header = \(header)\n,url = \(url)\n,method = \(method)\n,parameters = \(parameters)\n")
        return request
    }
    
    
    func buildUpload(_ request : LYHRequest<T>,success: @escaping ((_ upload: Alamofire.DataRequest) -> Void),failure: @escaping FailureHandler){
        //请求参数
        let parameters = buildParemeters(request)
        //接口地址
        let url : String
        if request.api().hasPrefix("http") {
            url = request.api()
            
        }else{
            url = request.baseUrl() + request.api()
        }
    
        //请求方式
        let method = request.method()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //添加参数
            for (key,value) in parameters{
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            //获取所有上传文件参数
            var files = [String:File]()
            request.addFiles(&files)
            //添加文件参数
            for(key,value) in files{
                multipartFormData.append(value.data, withName: key, fileName: value.fileName, mimeType: value.mimeType)
            }
            
        }, to: url, method: method.httpMethod) { (result) in
            switch result{
            case .success(let upload,_,_):
                success(upload)
            case .failure:
                let error = LYHNetworkError.requestFailed
                failure(error)
            }
        }
    }
}

//参数设置
extension LYHAgent{
    
    //生成参数
    fileprivate func buildParemeters(_ request: LYHRequest<T>)->[String:Any]{
        
        var pra = request.param
        request.addParameters(&pra)
        addGeneralParament(&pra)
        return pra
    }
    //添加默认参数
    fileprivate func addGeneralParament(_ parameters: inout [String:Any]){
        let configPra = LYHConfig.share.generalParament()
        for key in configPra.keys{
            parameters[key] = configPra[key]
        }
    }
    //添加默认请求头
    fileprivate func addGeneralHeader(_ headeres: inout [String:String]){
        let configPra = LYHConfig.share.generalHeader()
        for key in configPra.keys{
            headeres[key] = configPra[key]
        }
    }
}
