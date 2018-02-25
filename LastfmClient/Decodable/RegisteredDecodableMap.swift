//
//  RegisteredDecodableMap.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/25.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

struct RegisteredDecodableMap: Decodable {
    var decoded: Date

    private enum Registered: String, CodingKey {
        case text = "#text"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Registered.self)
        let time = try container.decode(Double.self, forKey: .text)
        let decoded = Date(timeIntervalSince1970: time)
        self.decoded = decoded
    }
}
