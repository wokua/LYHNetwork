# LYHNetwork
结合Alamofire和ObjectMapper的Swift网络封装
Network encapsulation library based on Alarmfire and ObjectMapper


how to use：The detail you can see this demo

import UIKit
import LYHNetwork
import ObjectMapper
//import SwiftyJSON

class ViewController: UIViewController {

//    fileprivate let api = AAApi()

override func viewDidLoad() {
super.viewDidLoad()

}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

api.manager.showHUD().on(_started: {

}, success: { (model) in

}) { (error) in

}.request()

}
}

fileprivate class JokeModel : Mappable{
var content : String = ""
required convenience init?(map: Map) {
self.init()
}

func mapping(map: Map) {
content <- map["content"]
}
}

fileprivate class AAApi : LYHRequest<[JokeModel]>{//（It can be an array<Mappable>、a model<Mappable>，()，String）

override func method() -> HTTPMethod {
return .get
}

override func api() -> String {
return "http://v.juhe.cn/joke/content/list.php"
}

override func addParameters(_ parameters: inout [String : Any]) {
parameters["key"] = "e6522dba527b0633ac079f2e217b1d5e"
parameters["sort"] = "asc"
parameters["page"] = 1
parameters["pagesize"] = 10
parameters["time"] = "1418816972"
}
}
