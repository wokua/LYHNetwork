//
//  LYHRequestManager
//  TFM
//
//  Created by lrk on 2018/10/24.
//  Copyright © 2018年 KF. All rights reserved.
//
import Foundation
import SVProgressHUD
import ObjectMapper

public class LYHRequestSubject<T>{
    weak var lyhrequest : LYHRequest<T>?
}

private var showHudTipKey = "showHudTipKey"

extension LYHRequestSubject{
    var isShowHud: Bool? {
        get {
            return objc_getAssociatedObject(self, &showHudTipKey) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &showHudTipKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension LYHRequestSubject{
    
    func showHUD() -> LYHRequestSubject<T> {
        isShowHud = true
        return self
    }
    
    func on(_started:(()->Void)? = nil,success: @escaping (_ value:T) -> Void, failure: @escaping FailureHandler) -> LYHRequestSubject<T> {
        
        _started?()
        self.lyhrequest?.success = {[weak self] (item) in
            guard let `self` = self else{return}
            if self.isShowHud == true{
                SVProgressHUD.dismiss()
            }
            success(item)
        }
        self.lyhrequest?.failure = {[weak self] (error) in
            guard let `self` = self else{return}
            if self.isShowHud == true{
                SVProgressHUD.showError(withStatus: error.message)
            }
            failure(error)
        }
        return self
    }
    
    fileprivate func updateFirstState(){
        if isShowHud == true {
            SVProgressHUD.show()
        }
        lyhrequest?.agent = LYHAgent<T>()
    }
    
}

extension LYHRequestSubject where T : Mappable{
    func request(){
        
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildRequest(request).responseObject(success: {[weak self] (value:T) in
            self?.lyhrequest?.success?(value)
            }, failure: {[weak self] (error) in
                self?.lyhrequest?.failure?(error)
        })
    }
    
    func upload(){
       
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildUpload(request, success: {[weak request] (upload) in
            upload.responseObject(success:request?.success, failure:request?.failure)
            }, failure: {[weak request] (error) in
                request?.failure?(error)
        })
    }
}

extension LYHRequestSubject where T : ArrayMappable{
    func request(){
       
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildRequest(request).responseArray(success: {[weak self] (value:T) in
            self?.lyhrequest?.success?(value)
            }, failure: {[weak self] (error) in
                self?.lyhrequest?.failure?(error)
        })
    }
    
    func upload(){
        
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildUpload(request, success: {[weak request] (upload) in
            upload.responseArray(success:request?.success, failure:request?.failure)
            }, failure: {[weak request] (error) in
                request?.failure?(error)
        })
    }
}

extension LYHRequestSubject where T == (){
    func request(){
       
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildRequest(request).responseNil(success: {[weak self] (value:T) in
            self?.lyhrequest?.success?(value)
            }, failure: {[weak self] (error) in
                self?.lyhrequest?.failure?(error)
        })
    }
    
    func upload(){
       
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildUpload(request, success: {[weak request] (upload) in
            upload.responseNil(success:request?.success, failure:request?.failure)
            }, failure: {[weak request] (error) in
                request?.failure?(error)
        })
    }
}

extension LYHRequestSubject where T == String{
    func request(){
       
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildRequest(request).responseString(success: {[weak self] (value:T) in
            self?.lyhrequest?.success?(value)
            }, failure: {[weak self] (error) in
                self?.lyhrequest?.failure?(error)
        })
    }
    
    func upload(){
       
        guard let request = lyhrequest else {
            return
        }
        updateFirstState()
        request.agent?.buildUpload(request, success: {[weak request] (upload) in
            upload.responseString(success:request?.success, failure:request?.failure)
            }, failure: {[weak request] (error) in
                request?.failure?(error)
        })
    }
}
