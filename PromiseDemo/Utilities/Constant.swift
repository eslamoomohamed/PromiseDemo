//
//  Constant.swift
//  PromiseDemo
//
//  Created by eslam mohamed on 02/08/2022.
//

import Foundation

enum State{
    case loading
    case error
    case empty
    case finished
}


class URLs {
    private static var baseUrl = "https://api.data.gov.sg/v1"
    
    static func traffic() -> String {
        return baseUrl + "/transport/traffic-images"
    }
}
