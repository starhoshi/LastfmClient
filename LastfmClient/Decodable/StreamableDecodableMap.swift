//
//  StreamableDecodableMap.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

struct StreamableDecodableMap: Decodable {
    var decoded: Bool

    private enum StreamableKeys: String, CodingKey {
        case fulltrack
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StreamableKeys.self)
        let streamable = try container.decode(StringCodableMap<Int>.self, forKey: .fulltrack).decoded == 1
        self.decoded = streamable
    }
}
