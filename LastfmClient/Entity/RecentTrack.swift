//
//  RecentTrack.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/24.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public protocol ListResponse {
    associatedtype List

    var list: [List] { get }
    var attr: Attr { get }
}

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

public struct Track: Decodable {
    public let name: String
    public let image: Image
    public let loved: Bool
    public let streamable: Bool
    public let mbid: String
    public let url: URL
    public let date: Date
    public let album: Album

    private enum CodingKeys: String, CodingKey {
        case name
        case image
        case loved
        case streamable
        case mbid
        case url
        case date
        case album
    }

    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        name = try decoder.decode(String.self, forKey: .name)
        image = try decoder.decode(ImageDecodableMap.self, forKey: .image).decoded
        loved = try decoder.decode(StringCodableMap<Int>.self, forKey: .loved).decoded == 1
        streamable = try decoder.decode(StringCodableMap<Int>.self, forKey: .streamable).decoded == 1
        mbid = try decoder.decode(String.self, forKey: .mbid)
        url = try decoder.decode(URL.self, forKey: .url)
        date = try decoder.decode(DateDecodableMap.self, forKey: .date).decoded
        album = try decoder.decode(Album.self, forKey: .album)
    }
}

public struct Album: Decodable {
    public let text: String
    public let mbid: String

    private enum CodingKeys: String, CodingKey {
        case text = "#text"
        case mbid
    }
}

