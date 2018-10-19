//
//  LYHResponse.swift
//  LYHNetworkDemo
//
//  Created by lrk on 2018/10/17.
//  Copyright © 2018年 sku. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

extension Alamofire.DataRequest{
    //解析单体
    func responseObject<T:Mappable>( success: ((_ value:T) -> Void)?,
                                     failure: FailureHandler?){
        let serializer = DataResponseSerializer<T>{request,response,data,error in
            print("request = \(String(describing: request))\n,response = \(String(describing: response))\n,data = \(String(describing: data))\n,error = \(String(describing: error))\n")
            var (requestError,json) = Alamofire.Request.vaildResponse(request, response: response, data: data, error: error)
            
            guard  requestError == nil else{
                return .failure(requestError!)
            }
            
            var value : [String:Any]?
            value = json!.dictionaryObject
            
            guard let object = Mapper<T>().map(JSON: value!) else{
                let error = LYHNetworkError.entityEncodFailed
                return .failure(error)
            }
            return .success(object)
        }
       respose(serializer, success: success, failure: failure)
    }
    
    //解析数组
    func responseArray<T:ArrayMappable>( success: ((_ value:T) -> Void)?,
                        failure: FailureHandler?){
        let serializer = DataResponseSerializer<T>{request,response,data,error in
            print("request = \(String(describing: request))\n,response = \(String(describing: response))\n,data = \(String(describing: data))\n,error = \(String(describing: error))\n")
            var (requestError,json) = Alamofire.Request.vaildResponse(request, response: response, data: data, error: error)

            guard  requestError == nil else{
                return .failure(requestError!)
            }
            guard let items = json!.arrayObject as? [[String : Any]] else {
                let error = LYHNetworkError.jsonEncodFailed
                return .failure(error)
            }
            let array = Mapper<T.V>().mapArray(JSONArray: items)
            return .success(array as! T)
        }

        respose(serializer, success: success, failure: failure)

    }
    
    //解析字符串
    func responseString( success: ((_ value:String) -> Void)?,
                           failure: FailureHandler?){
        respose(Alamofire.DataRequest.stringResponseSerializer(), success: success, failure: failure)
    }
    
    //解析空子段
    func responseNil( success: ((()) -> Void)?,
                         failure: FailureHandler?){
        let serializer = DataResponseSerializer<()>{request,response,data,error in
            print("request = \(String(describing: request))\n,response = \(String(describing: response))\n,data = \(String(describing: data))\n,error = \(String(describing: error))\n")
            let (requestError,_) = Alamofire.Request.vaildResponse(request, response: response, data: data, error: error)
            
            guard  requestError == nil else{
                return .failure(requestError!)
            }
           
            return .success(())
        }
        respose(serializer, success: success, failure: failure)
    }
    
    private func respose<T:Any>(_ serializer:DataResponseSerializer<T>,success:((_ value:T) -> Void)?,failure: FailureHandler?){
        response(responseSerializer: serializer) { (response) in
            switch response.result{
            case .success(let value):
                success?(value)
            case .failure(let error):
                failure?(error as! LYHNetworkError)
            }
        }
    }
}

extension Alamofire.Request{
    
    //解析返回数据
    static func vaildResponse(_ request: URLRequest?,
                              response: HTTPURLResponse?,
                              data: Data?, error: Error?) -> (LYHNetworkError?,JSON?){
        
        guard error == nil else{
            let error = LYHNetworkError.customFailed(code:-1200, message: (error?.localizedDescription)!)
            return (error,nil)
        }
        
        guard let data = data else {
            let error = LYHNetworkError.responseDataNilFailed
            return (error ,nil)
        }
        
        let jsonResponseSerializer = Alamofire.DataRequest.jsonResponseSerializer()
        let result = jsonResponseSerializer.serializeResponse(request,response,data,error)
        
        guard result.isSuccess else{
            let error = LYHNetworkError.requestFailed
            return(error,nil)
        }
        
        guard let value = result.value else{
            let error = LYHNetworkError.resultValueNilFailed
            return(error,nil)
        }
        let json = JSON(value)
        guard json.error == nil else{
            let error = LYHNetworkError.jsonEncodFailed
            return(error,nil)
        }
        
        var d = json
        for responseStr in LYHConfig.share.generalResponse() {
            d = d[responseStr]
        }
        guard d.error == nil else{
            let error = LYHNetworkError.jsonEncodFailed
            return(error,nil)
        }
        
        return (nil,d)
    }
    
}
