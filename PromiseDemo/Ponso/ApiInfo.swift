//
//  ApiInfo.swift
//  PromiseDemo
//
//  Created by eslam mohamed on 02/08/2022.
//

import Foundation

struct ApiInfo : Codable {
    let status : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
