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

    private enum CodingKeys: String, CodingKey {
        case name
        case image
        case loved
        case streamable
        case mbid
        case url
        case date
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
    }
}

//public struct ListResponse: Decodable {
//    public let name: String
//    public let realname: String?
//    public let url: URL
//    public let country: String
//    public var age: Int
//    public let gender: String
//    public let subscriber: Int
//    public let playcount: Int
//    public let playlists: Int
//    public let bootstrap: Int
//    public let registered: Date
//    public let image: Image
//
//    private enum CodingKeys: String, CodingKey {
//        case name
//        case realname
//        case url
//        case country
//        case age
//        case gender
//        case subscriber
//        case playcount
//        case playlists
//        case bootstrap
//        case registered
//        case image
//    }
//
//    private enum UserKeys: String, CodingKey {
//        case user
//    }
//
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: UserKeys.self)
//
//        let user = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
//        name = try user.decode(String.self, forKey: .name)
//        realname = try user.decodeIfPresent(String.self, forKey: .realname)
//        url = try user.decode(URL.self, forKey: .url)
//        country = try user.decode(String.self, forKey: .country)
//        age = try user.decode(StringCodableMap<Int>.self, forKey: .age).decoded
//        gender = try user.decode(String.self, forKey: .country)
//        subscriber = try user.decode(StringCodableMap<Int>.self, forKey: .subscriber).decoded
//        playcount = try user.decode(StringCodableMap<Int>.self, forKey: .playcount).decoded
//        playlists = try user.decode(StringCodableMap<Int>.self, forKey: .playlists).decoded
//        bootstrap = try user.decode(StringCodableMap<Int>.self, forKey: .bootstrap).decoded
//        registered = try user.decode(RegisteredDecodableMap.self, forKey: .registered).decoded
//        image = try user.decode(ImageDecodableMap.self, forKey: .image).decoded
//    }
//}
//

