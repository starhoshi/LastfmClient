//
//  Artist.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct Artist: Decodable {
    public let name: String
    public let mbid: String?
    public let url: URL

    private enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case url
    }

    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        name = try decoder.decode(String.self, forKey: .name)
        let mbid = try decoder.decodeIfPresent(String.self, forKey: .mbid)
        if let mbid = mbid, mbid != "" {
            self.mbid = mbid
        } else {
            self.mbid = nil
        }
        url = try decoder.decode(URL.self, forKey: .url)
    }
}
