//
//  LYHNetworkError.swift
//  LYHNetworkDemo
//
//  Created by lrk on 2018/10/17.
//  Copyright © 2018年 sku. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire

enum LYHNetworkError : Error {
    case connetionError
    case requestFailed
    case responseDataNilFailed
    case resultValueNilFailed
    case jsonEncodFailed
    case entityEncodFailed
    case jsonValueNoDataKeyFailed
    case jsonValueNoCodeKeyFailed
    case customFailed(code:Int , message : String)
}

extension LYHNetworkError : CustomNSError {
 
    static let errorDomain = "io.objc.networkError"
    var errorCode : Int {
        switch self {
        case .connetionError : return -1009
        case .requestFailed: return -80
        case .responseDataNilFailed: return -79
        case .resultValueNilFailed : return -78
        case .jsonEncodFailed : return -77
        case .entityEncodFailed : return -76
        case . jsonValueNoDataKeyFailed : return -75
        case .jsonValueNoCodeKeyFailed : return -74
        case .customFailed(let code, _) : return code
        }
    }
    
    var message : String {
        switch self {
        case .connetionError: return "conect error"
        case .requestFailed: return "request isFailure"
        case .responseDataNilFailed: return "Data could not be serialized. Input data was nil."
        case .resultValueNilFailed : return "result.value was nil"
        case .jsonEncodFailed : return "Json data encodeing error"
        case .entityEncodFailed : return ""
        case . jsonValueNoDataKeyFailed : return ""
        case .jsonValueNoCodeKeyFailed : return "`code` Field does not exist"
        case .customFailed(let code , let message) : return message
        }
    }
    
    var errorUserInfo : [String:Any] {
        return [:]
    }
}
