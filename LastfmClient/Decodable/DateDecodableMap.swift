//
//  DateDecodableMap.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/25.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

struct DateDecodableMap: Decodable {
    var decoded: Date

    private enum _Date: String, CodingKey {
        case uts
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: _Date.self)
        let time = try container.decode(StringCodableMap<Double>.self, forKey: .uts).decoded
        let decoded = Date(timeIntervalSince1970: time)
        self.decoded = decoded
    }
}
