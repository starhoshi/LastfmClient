//
//  TopTrack.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/25.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct TopTrack: Decodable {
    public let name: String
    public let duration: Int
    public let playcount: Int
    public let mbid: String
    public let url: URL
    public let streamable: Bool
    public let artist: Artist
    public let image: Image
    public let rank: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case duration
        case playcount
        case mbid
        case url
        case streamable
        case artist
        case image
        case rank = "@attr"
    }

    private enum StreamableKeys: String, CodingKey {
        case fulltrack
    }

    private enum RankKeys: String, CodingKey {
        case rank
    }

    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        name = try decoder.decode(String.self, forKey: .name)
        duration = try decoder.decode(StringCodableMap<Int>.self, forKey: .duration).decoded
        playcount = try decoder.decode(StringCodableMap<Int>.self, forKey: .playcount).decoded
        mbid = try decoder.decode(String.self, forKey: .mbid)
        url = try decoder.decode(URL.self, forKey: .url)
        streamable = try decoder.decode(StreamableDecodableMap.self, forKey: .streamable).decoded
        artist = try decoder.decode(Artist.self, forKey: .artist)
        image = try decoder.decode(ImageDecodableMap.self, forKey: .image).decoded
        let rankDecoder = try decoder.nestedContainer(keyedBy: RankKeys.self, forKey: .rank)
        rank = try rankDecoder.decode(StringCodableMap<Int>.self, forKey: .rank).decoded
    }
}
