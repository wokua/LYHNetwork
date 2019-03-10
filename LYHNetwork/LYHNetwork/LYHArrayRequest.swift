//
//  LYHArrayRequest
//  TFM
//
//  Created by lrk on 2018/10/24.
//  Copyright © 2018年 KF. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ArrayMappable {
    associatedtype V : Mappable
}

extension Array: ArrayMappable where Element : Mappable{
    typealias V = Element
}

