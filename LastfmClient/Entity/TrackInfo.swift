//
//  TrackInfo.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct Tag: Decodable {
    public let name: String
    public let url: URL
}

public struct TrackInfo: Decodable {
    public let name: String
    public let url: URL
    public let duration: Int
    public var streamable: Bool
    public let listeners: Int
    public let playcount: Int
    public let artist: Artist
//    public let toptags: [Tag]

    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case duration
        case streamable
        case listeners
        case playcount
        case artist
//        case toptags
    }

    private enum TrackKeys: String, CodingKey {
        case track
    }

    private enum StreamableKeys: String, CodingKey {
        case fulltrack
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: TrackKeys.self)

        let root = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .track)
        name = try root.decode(String.self, forKey: .name)
        url = try root.decode(URL.self, forKey: .url)
        duration = try root.decode(StringCodableMap<Int>.self, forKey: .duration).decoded
        streamable = try root.decode(StreamableDecodableMap.self, forKey: .streamable).decoded
        listeners = try root.decode(StringCodableMap<Int>.self, forKey: .listeners).decoded
        playcount = try root.decode(StringCodableMap<Int>.self, forKey: .playcount).decoded
        artist = try root.decode(Artist.self, forKey: .artist)
//        toptags = try user.decode(StringCodableMap<Int>.self, forKey: .bootstrap).decoded
    }
}
