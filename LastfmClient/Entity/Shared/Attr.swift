//
//  Attr.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/25.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct Attr: Decodable {
    public let user: String
    public let page: Int
    public let perPage: Int
    public let totalPages: Int
    public let total: Int

    enum CodingKeys: String, CodingKey {
        case user
        case page
        case perPage
        case totalPages
        case total
    }

    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        user = try decoder.decode(String.self, forKey: .user)
        page = try decoder.decode(StringCodableMap<Int>.self, forKey: .page).decoded
        perPage = try decoder.decode(StringCodableMap<Int>.self, forKey: .perPage).decoded
        totalPages = try decoder.decode(StringCodableMap<Int>.self, forKey: .totalPages).decoded
        total = try decoder.decode(StringCodableMap<Int>.self, forKey: .total).decoded
    }
}
