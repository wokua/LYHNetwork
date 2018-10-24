//
//  LYHArrayRequest.swift
//  LYHNetworkDemo
//
//  Created by lrk on 2018/10/18.
//  Copyright © 2018年 sku. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ArrayMappable {
    associatedtype V : Mappable
}

extension Array: ArrayMappable where Element : Mappable{
    typealias V = Element
}

